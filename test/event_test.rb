require './helper'

class EventTest < Test::Unit::TestCase

  def setup
    @event = create_event
  end

  def test_equals
    # check and see if it supers non-hashes
    assert !(@event == "a string"), "should return false for a string."

    # check and see if filter is returning true for a hash
    assert (@event == { :hash => true }), "should return true for a hash."
  end

end