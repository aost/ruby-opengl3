module OpenGL::FFI
  module ParsingFunctionInfo
    
    # Internal:
    # info - the Hash to parse
    # Returns [param_types, ret_types]
    def parse_function_info(info)
      ret = PRIVATE.parse_ret_type(info['return_type'])
      params = info['parameters'].map{|p|
                 PRIVATE.parse_param_type(p[0..-2])
               }
      # Result
      [ params, ret ]
    end
    
    # Internal:
    module PRIVATE
      
      def self.parse_ret_type(type_ary)
        return type_ary[0].to_sym if type_ary.count == 1
        raise RuntimeError, "invalid ret_type: #{type_ary.inspect}"
      end
      
      def self.parse_param_type(type_ary)
        ty = type_ary.dup
        ptr = ty.select{|t| t == '*' }.count
        dir = ty.select{|t| t == 'const' }.empty? ? :out : :in
        ty.reject!{|t| t == '*' || t == 'const' }
        raise unless ty.count == 1
        if ptr > 0
          # ty << :pointer while (ptr -= 1) > 0
          #ty << dir
          :"buffer_#{ dir }"
        else
          ty[0].to_sym
        end
      end
      
    end
    private_constant :PRIVATE
  end
end
