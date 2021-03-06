require_relative 'feature_loader'
module OpenGL::API
  # Internal: OpenGL Feature Loader
  class GLFeatureLoader < AbstractFeatureLoader
    
    protected
    
    def each_feature(&block)
      Dir[File.expand_path('../gl/*.yml', __FILE__)].each do |path|
        super(path, &block)
      end
    end
    
  end
  private_constant :GLFeatureLoader
  
  # Public: OpenGL Feature Loader
  module GL
    def self.[](*version)
      GLFeatureLoader.new(version.flatten)
    end
  end
end
