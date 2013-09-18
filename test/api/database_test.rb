require 'test_helper'

class API_DatabaseTest < MiniTest::Test
  
  def test_correctness
    #
    context = Object.new
    def context.finish; end
    #
    OpenGL::API::Builder.build(context) do |builder|
      assert_kind_of Hash, builder.send(:constants)
      assert_kind_of Hash, builder.send(:functions)
      # check constants
      builder.send(:constants).each do |name, value|
        assert_kind_of String, name
        assert_kind_of Integer, value
      end
      # check functions
      builder.send(:functions).each do |name, info|
        assert_kind_of String, name
        assert_kind_of Hash, info
        assert_includes info, 'return_type'
        assert_includes info, 'parameters'
        assert_kind_of Array, info['return_type']
        assert_kind_of Array, info['parameters']
        # check return type
        assert_return_type info['return_type']
        # check parameters
        info['parameters'].each{|p|
          assert_kind_of Array, p
          # check param type
          assert_parameter_type p[0..-2]
          # check param name
          assert_kind_of String, p.last
          assert_match /\A\w+\z/, p.last
        }
      end
    end
  end
  
  def assert_return_type(type_ary)
    assert_equal 1, type_ary.length
    assert_kind_of String, type_ary[-1]
    assert_includes %w(
      void string pointer
      GLenum GLboolean GLint GLuint GLsync
    ), type_ary[-1]
  end
  
  def assert_parameter_type(type_ary)
    type_ary.each{|t|
      assert_kind_of String, t
      assert_match /\A(\w+|\*)\z/, t
    }
  end
  
end
