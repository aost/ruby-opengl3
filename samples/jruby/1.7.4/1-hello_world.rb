require 'opengl'
java_import org.lwjgl.opengl.DisplayMode
java_import org.lwjgl.opengl.Display

mode = DisplayMode.new(800, 600)
Display.setDisplayMode(mode)
Display.setTitle('Hello World')
Display.create

# import OpenGL
include OpenGL::FFI::GL.create

puts "GL Version: #{ glGetString(GL_VERSION) }"
puts "GL Vendor: #{ glGetString(GL_VENDOR) }"
puts "GL Renderer: #{ glGetString(GL_RENDERER) }"
puts "GLSL Version: #{ glGetString(GL_SHADING_LANGUAGE_VERSION) }"

until Display.isCloseRequested
  glClear(GL_COLOR_BUFFER_BIT)
  Display.update
end

Display.destroy
