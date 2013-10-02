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
      unless @module.respond_to? name.to_sym
        Platform.attach_function(@module, name, info)
      end
    end
    
    def finish
      @module.freeze
    end
    
  end
end
