require 'test/unit'
require '../lib/em-emitter'

# create the object with a method to test
class TestObject
  def method_that_should_be_run(message)
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

def create_event
  @event = EM::Emitter::Event.new(
    { :event => "1", :hash => "2" },
    create_observer
  )
end