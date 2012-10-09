require 'eventmachine'
require './helper'

# create test object with Observable items
class ObservableTest
  include EM::Emitter::Observable

  attr_reader :result

  def initialize
    receiver({ :name => "event1" }, :receive_event_1)
  end

  def receive_event_1(message)
    @result = message
  end
end

class SecondObservableTest
  include EM::Emitter::Observable

  def initialize

  end

end


class EmitterTest < Test::Unit::TestCase

  def setup
    @observable = ObservableTest.new
    @second_observable = SecondObservableTest.new
  end

  def teardown
    EM::Emitter::clear_observers!
  end


  def test_internal_event
    # check the amount of observers is one from the setup
    assert_equal 1, EM::Emitter::listeners_count, "Starting listeners count is not as expected."
    EM.run do
      assert_not_equal "Firing event1", @observable.result, "The observable result is set before testing."

      EM.add_timer(1) do
        assert_equal "Firing event1", @observable.result, "The observable result was not set."
        EM.stop
      end

      @observable.emit({ :name => "event1" }, "Firing event1")
    end

  end

  def test_external_event
    # check the amount of observers is one from the setup
    assert_equal 1, EM::Emitter::listeners_count, "Starting listeners count is not as expected."
    EM.run do
      assert_not_equal "Firing external event", @observable.result, "The observable result is set before testing."

      EM.add_timer(1) do
        assert_equal "Firing external event", @observable.result, "The observable result was not set."
        EM.stop
      end

      @second_observable.emit({ :name => "event1" }, "Firing external event")
    end

  end

  def test_cloning_object_option_on
    # check the amount of observers is one from the setup
    assert_equal 1, EM::Emitter::listeners_count, "Starting listeners count is not as expected."
    @observable.uses_clone true
    EM.run do
      hash = { :hash => "value" }
      assert_not_equal hash, @observable.result, "The observable result is set before testing."
      assert_not_equal hash.object_id, @observable.result.object_id, "The objects are already the same!"

      EM.add_timer(1) do
        assert_equal hash, @observable.result, "The observable result was not set."
        assert_not_equal hash.object_id, @observable.result.object_id, "The objects are not the same!"
        EM.stop
      end

      @observable.emit({ :name => "event1" }, hash)
    end

  end

  def test_cloning_object_option_off
    # check the amount of observers is one from the setup
    assert_equal 1, EM::Emitter::listeners_count, "Starting listeners count is not as expected."

    @observable.uses_clone false
    EM.run do
      hash = { :hash => "value" }
      assert_not_equal hash, @observable.result, "The observable result is set before testing."
      assert_not_equal hash.object_id, @observable.result.object_id, "The objects are already the same!"

      EM.add_timer(1) do
        assert_equal hash, @observable.result, { :hash => "value" }
        assert_equal hash.object_id, @observable.result.object_id, "The objects are not the same!"
        EM.stop
      end

      @observable.emit({ :name => "event1" }, hash)
    end

  end

  def test_max_listeners
    # check the amount of observers is one from the setup
    assert_equal 1, EM::Emitter::listeners_count, "Starting listeners count is not as expected."

    # check the default is actually set
    assert_equal 50, EM::Emitter::max_listeners, "Max listeners default not correctly set."

    # set the max listener to a smaller number of 2
    EM::Emitter::max_listeners = 2

    # check that it has changed
    assert_equal 2, EM::Emitter::max_listeners, "Max listeners module var couldnt be changed."

    # add an extra event listener to the setup var
    assert_nothing_raised EM::Emitter::MaxObserversReachedException do
      @observable.receiver({ :name => "event2" }, :receive_event_1)
    end

    # check the amount of observers has changed
    assert_equal 2, EM::Emitter::listeners_count, "Listener count has not increased."

    assert_raise EM::Emitter::MaxObserversReachedException do
      @observable.receiver({ :name => "event3" }, :receive_event_1)
    end

  end

end