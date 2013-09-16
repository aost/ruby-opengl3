require_relative 'feature_loader'
module OpenGL::API
  # Internal: OpenGL ES Feature Loader
  class GLES2FeatureLoader < AbstractFeatureLoader
    
    protected
    
    def filename
      File.expand_path('../gles2.yml', __FILE__)
    end
    
  end
  private_constant :GLES2FeatureLoader
  
  # Public: OpenGL ES Feature Loader
  module GLES2
    def self.[](*version)
      GLES2FeatureLoader.new(version.flatten)
    end
  end
end
