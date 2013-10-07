module OpenGL::FFI
  module Platform
    
    # Internal:
    def self.get_function(name, param_types, ret_type)
      name = name.to_sym
      @functions ||= {}
      @functions[name] ||= begin
                             addr = GL.glXGetProcAddressARB(name.to_s)
                             ::FFI::Function.new(ret_type, param_types, addr)
                           end
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
