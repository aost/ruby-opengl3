require 'test_helper'
require 'lwjgl-jars'
java_import org.lwjgl.opengl.DisplayMode
java_import org.lwjgl.opengl.Display

#
class TestApp < MiniTest::Test
  
  def flush_buffers
  end
  
  def setup
    mode = DisplayMode.new(800, 600)
    Display.setDisplayMode(mode)
    Display.setTitle("Hello World")
    Display.create
  end
  
  def teardown
    Display.destroy
  end
  
end

