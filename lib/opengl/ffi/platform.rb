require_relative 'parsing_function_info'

module OpenGL::FFI
  module Platform
    extend ParsingFunctionInfo
    
    # Internal: Primitive Types
    PRIMITIVE_TYPES = Hash[ %w( GLenum uint32
                                GLbitfield uint32
                                GLboolean uint8
                                GLsizei int32
                                GLintptr long
                                GLsizeiptr long
                                GLbyte int8
                                GLubyte uint8
                                GLshort int16
                                GLushort uint16
                                GLint int32
                                GLuint uint32
                                GLint64 int64
                                GLuint64 uint64
                                GLhalf uint16
                                GLfloat float
                                GLdouble double
                                GLchar char
                                GLchar_pointer pointer
                                GLvoid void
                                GLsync pointer
                              ).map(&:to_sym).each_slice(2).to_a ]
    
    # Typedef types
    PRIMITIVE_TYPES.each do |gl_type, na_type|
      FFI.typedef na_type, gl_type
    end
    
    # Internal: Callback Types
    CALLBACK_TYPES = {
      GLDEBUGPROC: ::FFI::CallbackInfo.new(
                     FFI.find_type(:void), # return_type
                     [ :GLenum, # source
                       :GLenum, # type
                       :GLuint, # id
                       :GLenum, # severity
                       :GLsizei, # length
                       :GLchar_pointer, # message
                       :pointer # userParam
                     ].map{|t| FFI.find_type(t) }
                   )
    }
    
    # Typedef callback
    CALLBACK_TYPES.each do |gl_type, na_type|
      FFI.typedef na_type, gl_type
    end
  end
  
  require_relative File.join('platforms', ::FFI::Platform::OS)
end
