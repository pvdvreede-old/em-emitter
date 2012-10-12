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

require 'test/unit'
require '../lib/em-emitter'

# create the object with a method to test
class TestObject
  def method_that_should_be_run(message, event)
    "run #{message}"
  end
end



def create_observer
  observer = EM::Emitter::Observer.new(
      { :event => "1", :hash => "2" },
      TestObject.new,
      :method_that_should_be_run
  )
end

def create_bad_method_observer
  observer = EM::Emitter::Observer.new(
    { :event => "1", :hash => "2" },
    TestObject.new,
    :method_doesnt_exist
  )
end

def create_event
  @event = EM::Emitter::Event.new(
    { :first => "1", :second => "2", :third => "3", :fourth => "4" },
    create_observer
  )
end