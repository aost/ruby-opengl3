require 'test_helper'

class API_BuilderTest < MiniTest::Test
  
  def test_add_constant
    context = HashContext.new
    result = OpenGL::API::Builder.build(context) do |builder|
      builder.add_constant 'GL_TEXTURE_2D'
      builder.add_constant 'GL_NONE'
      builder.add_constant 'GL_VERTEX_SHADER'
    end
    assert_includes result[:constants], 'GL_TEXTURE_2D'
    assert_includes result[:constants], 'GL_VERTEX_SHADER'
    assert_equal 0, result[:constants].fetch('GL_NONE')
  end
  
  def test_add_and_rename_constant
    context = HashContext.new
    result = OpenGL::API::Builder.build(context) do |builder|
      builder.add_constant 'GL_TEXTURE_2D_EXT', 'GL_TEXTURE_2D'
    end
    assert_includes result[:constants], 'GL_TEXTURE_2D_EXT'
    refute_includes result[:constants], 'GL_TEXTURE_2D'
  end
  
  def test_add_function
    context = HashContext.new
    result = OpenGL::API::Builder.build(context) do |builder|
      builder.add_function 'glBindTexture'
      builder.add_function 'glShaderSource'
    end
    assert_includes result[:functions], 'glBindTexture'
    assert_includes result[:functions], 'glShaderSource'
  end
  
  def test_add_and_rename_function
    context = HashContext.new
    result = OpenGL::API::Builder.build(context) do |builder|
      builder.add_function 'glBindRenderbufferEXT', 'glBindRenderbuffer'
    end
    assert_includes result[:functions], 'glBindRenderbufferEXT'
    refute_includes result[:functions], 'glBindRenderbuffer'
  end
  
  class HashContext
    
    def initialize
      @context = { constants: {}, functions: {} }
    end
    
    def add_constant(name, orig_name, value)
      @context[:constants].store(name, value)
    end
    
    def add_function(name, orig_name, info)
      @context[:functions].store(name, info)
    end
    
    def finish
      @context
    end
    
  end
  
end
