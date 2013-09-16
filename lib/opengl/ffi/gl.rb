module OpenGL
  module FFI
    # Public: OpenGL Module Factory
    GL = Object.new
    
    def GL.create
      API::Builder.build(BuilderContext.new) do |builder|
        # check version
        builder.add_constant 'GL_VERSION'
        builder.add_function 'glGetString'
        mod = builder.context.module
        version = mod.glGetString(mod::GL_VERSION)[/\d+.\d+/].split('.')
        version.map!(&:to_i)
        # add features
        API::GL[version].add_to builder
        # TODO: add extensions
        # more?
        yield builder if block_given?
      end
    end
    
  end
end
