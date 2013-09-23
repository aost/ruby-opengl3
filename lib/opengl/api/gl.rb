require_relative 'feature'
module OpenGL::API
  # Public: OpenGL Feature Loader
  class GL < AbstractFeature
    
    protected
    
    def each_feature(&block)
      Dir[File.expand_path('../gl/*.yml', __FILE__)].each do |path|
        super(path, &block)
      end
    end
    
  end
end
