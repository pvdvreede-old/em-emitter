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


  def test_internal_event
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

end