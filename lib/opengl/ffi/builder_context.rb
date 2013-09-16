module OpenGL::FFI
  # Internal: Context
  class BuilderContext
    
    attr_reader :module
    
    def initialize
      @module = Module.new
    end
    
    def add_constant(name, orig_name, value)
      unless @module.const_defined? name
        @module.const_set(name.to_sym, value)
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
