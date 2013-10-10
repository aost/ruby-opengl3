require 'test_app'
require_relative 'hello'

class HelloCore41Test < TestApp
  include Hello
  
  def setup
    super profile: :core, version: [4, 1],
          forward_compatible: true
  rescue RuntimeError => e
    skip
  end
  
end
