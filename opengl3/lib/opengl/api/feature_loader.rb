module OpenGL::API
  # Internal: Abstract Feature Loader
  class AbstractFeatureLoader
    
    attr_reader :version
    
    def initialize(version)
      @version = version
    end
    
    def add_to(builder)
      each_feature do |feature|
        # compare version
        version_cmp = (feature['version'] <=> version)
        # quit the loop if the version is greater than you want
        break if version_cmp > 0
        # feed constants and functions
        feature['constants'].each {|n| builder.add_constant(n) }
        feature['functions'].each {|n| builder.add_function(n) }
      end
    end
    
    protected
    
    def each_feature
      file = File.open(filename)
      YAML.load_documents(file) {|doc|
        yield doc
      }
    ensure
      file.close
    end
    
    # override filename or each_feature
    
  end
  
  private_constant :AbstractFeatureLoader
end
