require 'test_app'
require_relative 'hello'

class HelloEsTest < TestApp
  include Hello
  
  def setup
    super api: :gles2
  rescue RuntimeError => e
    skip
  end
  
  def test_hello
    super(OpenGL::FFI::GLES2)
  end
  
end
