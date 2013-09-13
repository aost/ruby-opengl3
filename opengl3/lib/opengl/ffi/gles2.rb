module OpenGL
  module FFI
    # Public: OpenGL ES Module Factory
    GLES2 = Object.new
    
    def GLES2.create
      API::Builder.build(BuilderContext.new) do |builder|
        # check version
        builder.add_constant 'GL_VERSION'
        builder.add_function 'glGetString'
        mod = builder.context.module
        version = mod.glGetString(mod::GL_VERSION)[/\d+.\d+/].split('.')
        version.map!(&:to_i)
        # add features
        API::GLES2FeatureLoader.new(version).add_to(builder)
        # TODO: add extensions
      end
    end
    
  end
end
