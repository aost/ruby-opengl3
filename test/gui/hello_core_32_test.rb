require 'test_app'
require_relative 'hello'

class HelloCore32Test < TestApp
  include Hello
  
  def setup
    super profile: :core, version: [3, 2],
          forward_compatible: true
  rescue RuntimeError => e
    skip
  end
  
end
