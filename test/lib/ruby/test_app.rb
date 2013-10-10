require 'test_helper'
require 'glfw3'

# Initialize GLFW
Glfw.init

#
class TestApp < MiniTest::Test
  
  def flush_buffers
    @window.swap_buffers
  end
  
  def setup(options = {})
    Glfw::Window.default_window_hints
    if options[:profile] =~ /core/
      Glfw::Window.window_hint Glfw::OPENGL_PROFILE, Glfw::OPENGL_CORE_PROFILE
    end
    if options[:forward_compatible]
      Glfw::Window.window_hint Glfw::OPENGL_FORWARD_COMPAT, 1
    end
    if v = options[:version]
      Glfw::Window.window_hint Glfw::CONTEXT_VERSION_MAJOR, v.first
      Glfw::Window.window_hint Glfw::CONTEXT_VERSION_MINOR, v.last
    end
    if options[:api] =~ /gles2/
      Glfw::Window.window_hint Glfw::CLIENT_API, Glfw::OPENGL_ES_API
    end
    @window = Glfw::Window.new(800, 600, "Test")
    @window.make_context_current
  end
  
  def teardown
    @window.destroy
    @window = nil
  end
  
end

