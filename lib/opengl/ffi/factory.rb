module OpenGL
  module FFI
    class Factory
      
      def create
        API::Builder.build(BuilderContext.new) do |builder|
          # add features
          api(builder).add_to builder
          # add extensions
          builder.context.extensions.each{|e|
            API::Extension[e].add_to(builder)
          }
          # more?
          yield builder if block_given?
        end
      end
      
      # missing method: api(builder)
      
    end
    private_constant :Factory
  end
end
