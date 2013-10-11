require_relative 'factory'

module OpenGL
  module FFI
    # Public: OpenGL Module Factory
    GL = Factory.new
    
    # Interanl:
    def GL.api(builder)
      API::GL[builder.context.version]
    end
    
    GL.freeze
  end
end
