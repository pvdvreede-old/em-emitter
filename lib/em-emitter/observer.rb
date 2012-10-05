module EM
  module Emitter

    class Observer
      attr_accessor :object
      attr_accessor :event
      attr_accessor :method
      attr_reader   :is_active

      def initialize(event, object, method)
        @event = EM::Emitter::Event.new(event, self)
        @object = object
        @method = method
      end

      def call_action(data)
        @object.send(@method, data)
      end

      def ==(other)
        if other.class == Observer
        self.object_id == other.object_id
        else
        super
        end
      end

      def remove
        # TODO: add logic that doesnt mutate the observer array while in flight
        @is_active = false
      end

    end

  end
end