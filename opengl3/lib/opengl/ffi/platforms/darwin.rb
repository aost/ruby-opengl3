module OpenGL::FFI
  module Platform
    
    # Internal:
    def self.attach_function(mod, name, info)
      name = name.to_sym
      @functions ||= {}
      @functions[name] ||= begin
                             ptypes, rtype = parse_function_info(info)
                             GL.attach_function(name, ptypes, rtype)
                           end
      @functions[name].attach(mod, name.to_s)
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
