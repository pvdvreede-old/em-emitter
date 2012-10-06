require 'test/unit'
require '../lib/em-emitter'
require './helper'

class ObserverTest < Test::Unit::TestCase

  def setup
    @observer = EM::Emitter::Observer.new(
      { :event => "1", :hash => "2" },
      TestObject.new,
      :method_that_should_be_run
    )
  end

  def test_call_action
    # check that the return value of the method is returned
    assert_equal "run hello world", @observer.call_action("hello world"),
      "The observer does not call the method on evented object."
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

