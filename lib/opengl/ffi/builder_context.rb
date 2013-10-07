module OpenGL::FFI
  # Internal: Context
  class BuilderContext
    
    attr_reader :module
    attr_reader :profile
    attr_reader :version
    attr_reader :extensions
    
    def initialize
      @module = Module.new
      self.extend @module
    end
    
    def bootstrap(builder)
      mod = @module
      # get version
      builder.add_constant 'GL_VERSION'
      builder.add_function 'glGetString'
      @version = glGetString(mod::GL_VERSION)[/\d+.\d+/].split('.')
      @version.map!(&:to_i).freeze
      # get extensions
      builder.add_constant 'GL_EXTENSIONS'
      @extensions = if (@version <=> [3, 0]) < 0
                      glGetString(mod::GL_EXTENSIONS).split
                    else
                      builder.add_constant 'GL_NUM_EXTENSIONS'
                      builder.add_function 'glGetStringi'
                      builder.add_function 'glGetIntegerv'
                      n = ::FFI::Buffer.new_in(:GLint, 1) do |ptr|
                            glGetIntegerv(mod::GL_NUM_EXTENSIONS, ptr)
                            ptr.read_int32
                          end
                      n.times.map{|i| glGetStringi(mod::GL_EXTENSIONS, i) }
                    end
      @extensions.freeze
      # profile
      @profile = if (@version <=> [3, 0]) < 0
                   :compatibility
                 elsif @extensions.include? 'GL_ARB_compatibility'
                   :compatibility
                 else :core
                 end
      # add some attributes to the module
      _version, _profile, _extensions = @version, @profile, @extensions
      mod.define_singleton_method(:version){ _version }
      mod.define_singleton_method(:profile){ _profile }
      mod.define_singleton_method(:extensions){ _extensions }
    end
    
    def add_constant(name, orig_name, value)
      name = name.to_sym
      @module.tap do |mod|
        mod.const_set(name, value) unless mod.const_defined? name
      end
    end
    
    def add_function(name, orig_name, info)
      return if @module.method_defined? name
      # parse types
      ret_type = parse_return_type(info)
      params = parse_parameter_types(info)
      # get function
      func = Platform.get_function(name, params, ret_type)
      # TODO: wrap function
      # attach to module
      func.attach(@module, name)
    end
    
    def finish
      @module.freeze
    end
    
    private
    
    def parse_return_type(info)
      rtype = info.key?('ruby') && info['ruby']['__return']
      rtype ||= info['return_type'] || :void
      rtype = :pointer if rtype == %w(void *)
      rtype.to_sym
    end
    
    def parse_parameter_type(param, info)
      pname = param[-1]
      ptype = (info.key?('ruby') && info['ruby'][pname]) || param[0..-2]
      if ptype.is_a? Array
        ty = ptype.dup
        ptr = ty.select{|t| t == '*' }.count
        dir = ty.select{|t| t == 'in' }.empty? ? :out : :in
        ty.reject!{|t| t == '*' || t == 'in' || t == 'out' }
        ptype = ptr > 0 ? :"buffer_#{ dir }" : ty[0].to_sym
      end
      ptype.to_sym
    end
    
    def parse_parameter_types(info)
      info['parameters'].map{|p| parse_parameter_type(p, info) }
    end
    
  end
end
