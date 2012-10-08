require './helper'

class EventTest < Test::Unit::TestCase

  def setup
    @event = create_event
  end

  def test_equals
    # check and see if it supers non-hashes
    assert !(@event == "a string"), "should return false for a string."

    # test exact match
    assert (@event == { :first => "1", :second => "2", :third => "3", :fourth => "4" }), "Not returning exact match properly."

    # test all event elements plus extras
    assert (@event == { :first => "1", :second => "2", :third => "3", :fourth => "4", :fifth => "5" }), "Not returning when extra in hash."

    # test false when hash key is different
    assert !(@event == { :first_wrong => "1", :second => "2", :third => "3", :fourth => "4" }), "Not returning exact match properly."
    assert !(@event == { :first_wrong => "1", :second => "2", :third => "3", :fourth => "4", :fifth => "5" }), "Not returning when extra in hash."

    # test false when hash value is different
    assert !(@event == { :first => "wrong", :second => "2", :third => "3", :fourth => "4" }), "Not returning exact match properly."
    assert !(@event == { :first => "wrong", :second => "2", :third => "3", :fourth => "4", :fifth => "5" }), "Not returning when extra in hash."
  end

end