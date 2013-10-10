module Hello
  
  def test_hello
    m = OpenGL::FFI::GL.create
    extend(m)
    # singleton_class.send :include, m
    puts "GL Version: #{ glGetString(m::GL_VERSION) }"
    puts "GL Vendor: #{ glGetString(m::GL_VENDOR) }"
    puts "GL Renderer: #{ glGetString(m::GL_RENDERER) }"
    puts "GLSL Version: #{ glGetString(m::GL_SHADING_LANGUAGE_VERSION) }"
    puts "Version: #{ m.version.inspect }"
    puts "Profile: #{ m.profile }"
    puts "Extensions:"
    puts m.extensions
    glClear(m::GL_COLOR_BUFFER_BIT)
    glFinish()
    flush_buffers
  end
  
end
