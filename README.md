# OpenGL (opengl3)

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/davll/ruby-opengl)

OpenGL wrapper library for Ruby

* Pure Ruby, no C/C++/Java extension included (thanks to ffi gem)
* OpenGL 2.1 ~ 4.4
* Ruby-style wrapper (not complete)

Tested on

* OS X Mountain Lion (MRI 2.0.0, JRuby 1.7)

## Installation

Add this line to your application's Gemfile:

    gem 'opengl3', :require => 'opengl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opengl3

## Examples

Sample codes are in `platform/ruby` and `platform/jruby`

```RUBY
require 'opengl'
# ...
m = OpenGL::FFI::GL.create
# => m is a module containing constants and functions
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
