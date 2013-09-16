module OpenGL::FFI
  module Platform
    
    # Internal:
    def self.attach_function(mod, name, info)
      name = name.to_sym
      @functions ||= {}
      @functions[name] ||= begin
                             ptypes, rtype = parse_function_info(info)
                             addr = GL.glXGetProcAddressARB(name.to_s)
                             ::FFI::Function.new(rtype, ptypes, addr)
                           end
      @functions[name].attach(mod, name.to_s)
    end
    
    # Internal:
    module GL
      extend ::FFI::Library
      ffi_lib 'libGL.so.1'
      callback :proc, [], :void
      attach_function :glXGetProcAddressARB, [:string], :proc
      attach_function :glXGetCurrentContext, [], :pointer
    end
    private_constant :GL
  end
end
