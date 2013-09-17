require 'test_app'

class HelloTest < TestApp
  
  def test_hello
    m = OpenGL::FFI::GL.create
    extend(m)
    puts "GL Version: #{ glGetString(m::GL_VERSION) }"
    puts "GL Vendor: #{ glGetString(m::GL_VENDOR) }"
    puts "GL Renderer: #{ glGetString(m::GL_RENDERER) }"
    puts "GLSL Version: #{ glGetString(m::GL_SHADING_LANGUAGE_VERSION) }"
    glClear(m::GL_COLOR_BUFFER_BIT)
    glFinish()
    flush_buffers
  end
  
end
