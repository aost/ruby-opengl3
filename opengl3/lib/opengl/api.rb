module OpenGL
  module API
    root = File.expand_path('../api', __FILE__)
    
    # Builder
    autoload :Builder, File.join(root, 'builder')
    
    # Feature
    autoload :GL, File.join(root, 'gl')
    autoload :GLES2, File.join(root, 'gles2')
    
  end
end
