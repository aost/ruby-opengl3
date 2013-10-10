module OpenGL::API
  class Platform
    
    def initialize
    end
    
    def add_type(name)
    end
    
    def add_callback(name)
    end
    
    private
    
    def typedefs
      @typedefs ||= YAML.load(File.join(ROOT, "typedefs.yml"))
    end
    
    def callbacks
      @callbacks ||= YAML.load(File.join(ROOT, "callbacks.yml"))
    end
    
  end
end
