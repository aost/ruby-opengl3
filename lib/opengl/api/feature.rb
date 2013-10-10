module OpenGL::API
  # Internal: Abstract Feature
  class AbstractFeature < Extension
    
    def self.[](*version)
      new(version.flatten)
    end
    
    private_class_method :new
    def initialize(version)
      super(:"GL_VERSION_#{ version.join('_') }")
      @version = version
    end
    
    attr_reader :version
    
    protected
    
    def can_apply?(doc, builder)
      # compare version
      version_cmp = (doc['version'] <=> version)
      # pass if the version is older than or equal to you want
      version_cmp <= 0 && super
    end
    
  end
  
  private_constant :AbstractFeature
end
