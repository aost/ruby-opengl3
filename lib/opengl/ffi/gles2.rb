module OpenGL
  module FFI
    # Public: OpenGL ES Module Factory
    GLES2 = GL.dup
    
    # Internal:
    def GLES2.api(version)
      API::GLES2[version]
    end
    
    GLES2.freeze
  end
end
