require 'yaml'

module OpenGL::API
  # Public: API Builder
  class Builder
    
    private_class_method :new
    
    # Public: Invoke Builder
    #
    # context - The Object to be manipulated
    #
    # Examples
    #
    #   class MyContext
    #     
    #     def add_constant(name, orig_name, value)
    #       constants[name] = value
    #     end
    #     
    #     def add_function(name, orig_name, info)
    #       functions[name] = Func.new(info)
    #     end
    #     
    #     def finish
    #       [constants, functions]
    #     end
    #     
    #   end
    #   
    #   context = MyContext.new
    #   
    #   Builder.build(context) do |builder|
    #     builder.add_constant 'GL_TEXTURE_2D'
    #     builder.add_function 'glBindTexture'
    #   end
    #   # => result of context.finish
    #
    # Returns the Object result of context.finish
    #
    def self.build(context)
      # create builder and assign context
      builder = new(context)
      # process
      yield builder
      # return
      context.finish
    end
    
    # Public: Context
    attr_reader :context
    
    # Public: Add Constant
    def add_constant(name, orig_name = nil, options = {})
      orig_name ||= name
      value = options[:value] || constants.fetch(orig_name)
      @context.add_constant(name, orig_name, value)
    end
    
    # Public: Add Function
    def add_function(name, orig_name = nil, options = {})
      orig_name ||= name
      info = options[:decl] || functions.fetch(orig_name)
      @context.add_function(name, orig_name, info)
    end
    
    # Internal:
    def initialize(context)
      @context = context
    end
    
    private
    
    # Internal:
    def constants
      @constants ||= YAML.load_file(File.join(ROOT, "constants.yml"))
    end
    
    # Internal:
    def functions
      @functions ||= YAML.load_file(File.join(ROOT, "functions.yml"))
    end
    
    # Internal:
    ROOT = File.expand_path("..", __FILE__)
    private_constant :ROOT
    
  end
end
