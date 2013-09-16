require 'test_helper'
require_relative 'context'

class API_GLES2Test < MiniTest::Test
  
  def test_es_2_0
    mod = OpenGL::API::Builder.build(Context.new) do |builder|
      OpenGL::API::GLES2[2,0].add_to(builder)
    end
    assert_operator mod, :const_defined?, :GL_SHADER_BINARY_FORMATS
    assert_operator mod, :const_defined?, :GL_TEXTURE_2D
    assert_respond_to mod, :glUseProgram
    assert_respond_to mod, :glShaderBinary
    assert_respond_to mod, :glVertexAttribPointer
  end
  
  def test_es_3_0
    mod = OpenGL::API::Builder.build(Context.new) do |builder|
      OpenGL::API::GLES2[3,0].add_to(builder)
    end
    
    # 2.0
    assert_includes mod.constants, :GL_TRIANGLES
    assert_respond_to mod, :glEnableVertexAttribArray
    # 3.0
    assert_includes mod.constants, :GL_RG
    assert_includes mod.constants, :GL_UNIFORM_BUFFER
    assert_respond_to mod, :glBindSampler
    assert_respond_to mod, :glWaitSync
  end
  
end
