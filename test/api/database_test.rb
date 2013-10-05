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
        # check return type
        assert_return_type name, info
        # check parameters
        assert_kind_of Array, info['parameters']
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
  
  def assert_return_type(name, info)
    ret_type = info['return_type']
    ret_type_rb = (info['ruby'] || {})['__return']
    assert case ret_type
           when nil
             ret_type_rb.nil?
           when /\AGL(enum|boolean|int|uint|sync)\z/
             ret_type_rb.nil?
           when %w(const GLubyte *)
             ret_type_rb == 'string'
           when %w(void *)
             ret_type_rb.nil?
           else false
           end, "Invalid ret type #{info['return_type'].inspect} of #{name}"
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
