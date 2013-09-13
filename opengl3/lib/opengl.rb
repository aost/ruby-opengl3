require_relative "opengl/version"

# OpenGL library for Ruby
module OpenGL
  root = File.expand_path('../opengl', __FILE__)
  autoload :API, File.join(root, 'api')
  autoload :FFI, File.join(root, "ffi")
end
