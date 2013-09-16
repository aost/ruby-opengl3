class Context
  
  def initialize
    @module = Module.new
  end
  
  def add_constant(name, orig_name, value)
    @module.const_set name.to_sym, value
  end
  
  def add_function(name, orig_name, info)
    @module.send :define_method, name.to_sym do |*args|
      info
    end
  end
  
  def finish
    @module.extend(@module).freeze
  end
  
end
