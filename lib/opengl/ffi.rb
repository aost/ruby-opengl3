gem 'ffi'
require 'ffi'

module OpenGL
  module FFI
    root = File.expand_path('../ffi', __FILE__)
    autoload :Platform, File.join(root, 'platform')
    autoload :BuilderContext, File.join(root, 'builder_context')
    
    # Module Factory
    autoload :GL, File.join(root, 'gl')
    autoload :GLES2, File.join(root, 'gles2')
  end
end
