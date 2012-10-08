module EM
  module Emitter

    class Observer
      attr_reader :object
      attr_reader :event
      attr_reader :method
      attr_reader :is_active

      def initialize(event, object, method)
        @event = EM::Emitter::Event.new(event, self)
        @object = object
        @method = method
        @is_active = true
      end

      def call_action(data)
        # only invoke the method if it can be invoked
        if @object.nil? == false && @object.respond_to?(@method)
          @object.send(@method, data)
        end
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