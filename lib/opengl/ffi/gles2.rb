require_relative 'factory'

module OpenGL
  module FFI
    # Public: OpenGL Module Factory
    GLES2 = Factory.new
    
    # Interanl:
    def GLES2.api(builder)
      API::GLES2[builder.context.version]
    end
    
    GLES2.freeze
  end
end
