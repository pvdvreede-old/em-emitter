module EM
  module Emitter
    @@observers = []

    def self.add_observer(object, event, method_to_call)
      @@observers << EM::Emitter::Observer.new(event, object, method_to_call)
      @@observers.count
    end

    def self.remove_observer(observer)
      @@observers.delete_if { |x| x == observer }
    end

    def self.emit(object, event, data)
      # remove non active items first
      @@observers.delete_if { |x| x.is_active == false }

      @@observers.each do |ob|
        if ob.event == event
          # call the method on the object with the data
          ob.call_action(data)
        end
      end
    end
  end
end