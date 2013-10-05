module OpenGL::FFI
  module ParsingFunctionInfo
    
    # Internal:
    # info - the Hash to parse
    # Returns [param_types, ret_types]
    def parse_function_info(info)
      # return type
      rt = info.fetch('ruby', {})['__return'] ||
           info['return_type'] ||
           :void
      rt = :pointer if rt == %w(void *)
      return_type = rt.to_sym
      # parameter types
      params = info['parameters'].map{|p|
                 PRIVATE.parse_param_type(p[0..-2])
               }
      # Result
      [ params, return_type ]
    end
    
    # Internal:
    module PRIVATE
      
      def self.parse_param_type(type_ary)
        ty = type_ary.dup
        ptr = ty.select{|t| t == '*' }.count
        dir = ty.select{|t| t == 'in' }.empty? ? :out : :in
        ty.reject!{|t| t == '*' || t == 'in' || t == 'out' }
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
