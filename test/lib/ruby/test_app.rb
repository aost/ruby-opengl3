require 'test_helper'
require 'glfw3'

# Initialize GLFW
Glfw.init

#
class TestApp < MiniTest::Test
  
  def flush_buffers
    @window.swap_buffers
  end
  
  def setup
    @window = Glfw::Window.new(800, 600, "Test")
    @window.make_context_current
  end
  
  def teardown
    @window.destroy
    @window = nil
  end
  
end

