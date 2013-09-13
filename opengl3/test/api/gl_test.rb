require 'test_helper'
require_relative 'context'

class API_GLES2Test < MiniTest::Test
  
  def test_1_1
    mod = OpenGL::API::Builder.build(Context.new) do |builder|
      OpenGL::API::GL[1,1].add_to(builder)
    end
    assert_includes mod.constants, :GL_TEXTURE_2D
    assert_respond_to mod, :glEnable
  end
  
end
