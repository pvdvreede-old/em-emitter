module EM
  module Emitter
    @@observers = []
    @@max_listeners = 50

    def self.max_listeners
      @@max_listeners
    end
    # TODO add system events for when an observer is added and removed
    def self.max_listeners=(n)
      # TODO make this unchangeable once EM is running
      @@max_listeners = n
    end

    def self.listeners_count
      @@observers.count
    end

    def self.add_observer(object, event, method_to_call)
      raise EM::Emitter::MaxObserversReachedException.new if @@observers.count >= @@max_listeners

      observer = EM::Emitter::Observer.new(event, object, method_to_call)

      @@observers << observer

      observer
    end

    def self.remove_observer(observer)
      @@observers.delete_if { |x| x == observer }
    end

    def self.clear_observers!
      @@observers = []
    end

    def self.emit(object, event, data)
      @@observers.each do |ob|
        if ob.is_active && ob.event == event
          # make the observer method calls async
          EM.next_tick do
            # call the method on the object with the data
            ob.call_action(data)
          end
        end
      end

      EM.next_tick do
        # remove non active items
        @@observers.delete_if { |x| x.is_active == false }
      end
    end
  end
end