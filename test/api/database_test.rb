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
        msg = "Constant: #{ name }"
        assert_kind_of String, name, msg
        assert_kind_of Integer, value, msg
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
        assert_return_type info['return_type'], func: name
        # check parameters
        info['parameters'].each{|p|
          assert_kind_of Array, p
          # check param name
          assert_kind_of String, p.last
          assert_match /\A\w+\z/, p.last
          # check param type
          assert_parameter_type p[0..-2], func: name, name: p.last
        }
      end
    end
  end
  
  def assert_return_type(type_ary, options)
    msg = "Function: #{ options[:func] }"
    type_ary.each{|t| assert_kind_of String, t, msg }
    case type_ary
    when %w(void) then true
    when %w(const GLubyte *) then true
    when %w(void *) then true
    when %w(GLenum) then true
    when %w(GLboolean) then true
    when %w(GLint) then true
    when %w(GLuint) then true
    when %w(GLsync) then true
    else flunk "Illegal Return Type: [#{ type_ary.join(', ') }] (#{msg})"
    end
  end
  
  def assert_parameter_type(type_ary, options)
    msg = "Funcion: #{ options[:func] }, Parameter: #{ options[:name] }"
    assert_operator 1, :<=, type_ary.length, msg
    type_ary.each{|t| assert_kind_of String, t, msg }
    base = []
    base << type_ary.pop while '*' == type_ary[-1]
    base << type_ary.pop
    assert_match /\A\w+\z/, base.last, msg
    if base.any?{|o| o == '*' } # pointer type
      assert_match /\A(in|out)\z/, type_ary[0], msg
    end
  end
  
end
