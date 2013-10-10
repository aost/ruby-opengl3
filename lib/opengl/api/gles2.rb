require_relative 'feature'
module OpenGL::API
  # Public: OpenGL ES Feature Loader
  class GLES2 < AbstractFeature
    
    private
    
    def open_file(&blk)
      super(File.expand_path('../gles2.yml', __FILE__), &blk)
    end
    
  end
end
