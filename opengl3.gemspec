# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opengl/version'

Gem::Specification.new do |gem|
  gem.name          = "opengl3"
  gem.version       = OpenGL::VERSION
  gem.authors       = ["David Lin"]
  gem.email         = ["davll.xc@gmail.com"]
  gem.description   = %q{An OpenGL wrapper library for Ruby (OpenGL 2.1-4.2)}
  gem.summary       = %q{OpenGL}
  gem.homepage      = "https://github.com/davll/ruby-opengl"
  
  files = `git ls-files`.split($/)
  lib_files = files.select{|x| File.fnmatch? 'lib/**/*', x }
  gem.files         = lib_files + %w(LICENSE)
  gem.require_paths = %w(lib)
  
  gem.required_ruby_version = ">= 1.9.2"
  gem.add_dependency "ffi", ">= 1.2.0"
  gem.add_development_dependency "minitest", ">= 5.0.0"
end
