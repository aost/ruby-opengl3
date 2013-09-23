module OpenGL
  module FFI
    # Public: OpenGL Module Factory
    GL = Object.new
    
    # Public:
    def GL.create
      API::Builder.build(BuilderContext.new) do |builder|
        # check version
        builder.add_constant 'GL_VERSION'
        builder.add_function 'glGetString'
        mod = builder.context.module
        version = mod.glGetString(mod::GL_VERSION)[/\d+.\d+/].split('.')
        version.map!(&:to_i).freeze
        # 
        mod.define_singleton_method(:version){ version }
        # add features
        api(version).add_to builder
        # add extensions
        exts = extensions(mod).freeze
        mod.define_singleton_method(:extensions){ exts }
        exts.each{|e| API::Extension[e].add_to(builder) }
        # more?
        yield builder if block_given?
      end
    end
    
    # Interanl:
    def GL.api(version)
      API::GL[version]
    end
    
    # Internal:
    def GL.extensions(mod)
      if (mod.version <=> [3, 0]) < 0
        mod.glGetString(mod::GL_EXTENSIONS).split
      else
        mod.glGetIntegerv(mod::GL_NUM_EXTENSIONS).times.map{|i|
          mod.glGetStringi(mod::GL_EXTENSIONS, i)
        }
      end
    end
    
  end
end
