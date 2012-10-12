# Copyright (C) 2012 Paul Van de Vreede
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

Gem::Specification.new do |s|
  s.name        = 'em-emitter'
  s.version     = '0.9.0.beta.2'
  s.date        = Time.now
  s.summary     = "Global event emitter based on the observer pattern for Eventmachine."
  s.description = "You can use em-emitter to communicate with other objects in the Eventmachine reactor by subscribing to events and emitting them with encapsulated pieces of data."
  s.author      = "Paul Van de Vreede"
  s.email       = 'paul@vdvreede.net'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/pvdvreede/em-emitter'
  s.platform    = Gem::Platform::RUBY

  s.add_runtime_dependency "eventmachine", "~> 1.0"
  s.add_development_dependency "eventmachine", "~> 1.0"
end