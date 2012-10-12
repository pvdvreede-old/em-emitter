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

require './helper'

class ObserverTest < Test::Unit::TestCase

  def setup
    @observer = create_observer
    @no_method_observer = create_bad_method_observer
  end

  def test_call_action
    # check that the return value of the method is returned
    assert_equal "run hello world", @observer.call_action("hello world", {}),
      "The observer does not call the method on evented object."

    # test that calling a non existent method doesnt throw an exception
    assert_nothing_raised do
      assert !@no_method_observer.call_action("hello world", {}), "Bad method call didnt return a nil value"
    end
  end

  def test_equals
    # check that the current object does not equal and new one but does equal it self
    assert !(@observer == EM::Emitter::Observer.new(
        { :event => "1", :hash => "2" },
        TestObject.new,
        :method_that_should_be_run
      )), "The observer equals a brand new one."
    assert @observer == @observer, "The same observer does not equal itself."

    # check that the current object does not equal a clone
    assert !(@observer == @observer.clone), "Clone of observer equals actual observer."
  end

  def test_remove
    # check that the is_active attribute is false when called
    assert @observer.is_active == true, "is_active not defaulted to true."
    @observer.remove
    assert @observer.is_active == false, "is_active not set to false on remove call."
  end

end

