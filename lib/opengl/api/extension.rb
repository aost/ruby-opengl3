module OpenGL::API
  class Extension
    
    def self.[](name)
      new(name)
    end
    
    private_class_method :new
    def initialize(name)
      raise unless /\A\w+\z/ =~ name
      @name = name
    end
    
    attr_reader :name
    
    def add_to(builder)
      each_doc do |doc|
        # Check Conditions
        next unless can_apply?(doc, builder)
        # Add Constants
        doc['constants'].each {|name, info|
          orig_name = (info.is_a?(String) ? info : nil)
          value = (info.is_a?(Integer) ? info : nil)
          builder.add_constant(name, orig_name, value: value)
        }
        # Add Functions
        doc['functions'].each {|name, info|
          orig_name = (info.is_a?(String) ? info : nil)
          info = (info.is_a?(Hash) ? info : nil)
          builder.add_function(name, orig_name, decl: info)
        }
      end
    end
    
    private
    
    def can_apply?(doc, builder)
      true
    end
    
    def open_file(path = nil)
      path ||= File.expand_path("../extensions/#{name}.yml", __FILE__)
      return unless File.file?(path)
      file = File.open(path, 'r')
      begin
        yield file
      ensure
        file.close
      end
    end
    
    def each_doc(&blk)
      open_file do |file|
        YAML.load_documents(file, &blk)
      end
    end
    
  end
end
