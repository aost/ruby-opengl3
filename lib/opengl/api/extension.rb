module OpenGL::API
  class Extension
    
    def self.[](name)
      raise unless /\A\w+\z/ =~ name
      path = File.expand_path("../extensions/#{name}.yml", __FILE__)
      new(name, path)
    end
    
    private_class_method :new
    def initialize(name, path)
      @name, @path = name, path
    end
    
    attr_reader :name
    
    def add_to(builder)
      each_doc do |doc|
        doc['constants'].each {|name, info|
          orig_name = (info.is_a?(String) ? info : nil)
          value = (info.is_a?(Integer) ? info : nil)
          builder.add_constant(name, orig_name, value: value)
        }
        doc['functions'].each {|name, info|
          orig_name = (info.is_a?(String) ? info : nil)
          info = (info.is_a?(Hash) ? info : nil)
          builder.add_function(name, orig_name, decl: info)
        }
      end
    end
    
    private
    
    def each_doc(&blk)
      return unless File.file?(@path)
      begin
        file = File.open(@path)
        YAML.load_documents(file, &blk)
      ensure
        file.close
      end
    end
    
  end
end
