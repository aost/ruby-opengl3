require_relative 'feature'
module OpenGL::API
  # Public: OpenGL ES Feature Loader
  class GLES2 < AbstractFeature
    
    protected
    
    def filename
      File.expand_path('../gles2.yml', __FILE__)
    end
    
  end
end
