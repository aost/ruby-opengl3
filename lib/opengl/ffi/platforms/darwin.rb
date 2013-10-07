module OpenGL::FFI
  module Platform
    
    # Internal:
    def self.get_function(name, param_types, ret_type)
      name = name.to_sym
      @functions ||= {}
      @functions[name] ||= GL.attach_function(name, param_types, ret_type)
    end
    
    # Internal:
    module GL
      extend ::FFI::Library
      ffi_lib '/System/Library/Frameworks/OpenGL.framework/OpenGL'
      attach_function :CGLGetCurrentContext, [], :pointer
    end
    private_constant :GL
  end
end
