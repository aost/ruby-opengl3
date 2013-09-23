require 'test_helper'
require_relative 'context'

class API_ExtTest < MiniTest::Test
  
  def test_ext1
    mod = OpenGL::API::Builder.build(Context.new) do |builder|
      OpenGL::API::Extension['GL_NV_primitive_restart'].add_to(builder)
    end
    assert_operator mod, :const_defined?, :GL_PRIMITIVE_RESTART_NV
    assert_operator mod, :const_defined?, :GL_PRIMITIVE_RESTART_INDEX_NV
    assert_respond_to mod, :glPrimitiveRestartNV
    assert_respond_to mod, :glPrimitiveRestartIndexNV
  end
  
end
