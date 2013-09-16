require 'test_helper'
require_relative 'context'

class API_GLTest < MiniTest::Test
  
  def test_1_1
    mod = OpenGL::API::Builder.build(Context.new) do |builder|
      OpenGL::API::GL[1,1].add_to(builder)
    end
    assert_operator mod, :const_defined?, :GL_TEXTURE_2D
    assert_respond_to mod, :glEnable
  end
  
end
