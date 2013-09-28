module OpenGL
  module FFI
    # Public: OpenGL Module Factory
    GL = Object.new
    
    # Public:
    def GL.create
      API::Builder.build(BuilderContext.new) do |builder|
        # add features
        api(builder.context.version).add_to builder
        # add extensions
        builder.context.extensions.each{|e|
          API::Extension[e].add_to(builder)
        }
        # more?
        yield builder if block_given?
      end
    end
    
    # Interanl:
    def GL.api(version)
      API::GL[version]
    end
    
    GL.freeze
  end
end
