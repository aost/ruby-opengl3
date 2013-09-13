require 'opengl'
require 'glfw3'

Glfw.init
window = Glfw::Window.new(800, 600, "Hello World")
window.set_close_callback {|w| w.should_close = true }
window.make_context_current

# import OpenGL
include OpenGL::FFI::GL.create

puts "GL Version: #{ glGetString(GL_VERSION) }"
puts "GL Vendor: #{ glGetString(GL_VENDOR) }"
puts "GL Renderer: #{ glGetString(GL_RENDERER) }"
puts "GLSL Version: #{ glGetString(GL_SHADING_LANGUAGE_VERSION) }"

begin
  Glfw.wait_events
  glClear(GL_COLOR_BUFFER_BIT)
  window.swap_buffers
end until window.should_close?

window.destroy
