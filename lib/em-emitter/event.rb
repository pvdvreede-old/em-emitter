module EM
  module Emitter

    class Event
      attr_reader :event_hash
      attr_reader :observer

      def initialize(hash, observer)
        @event_hash = hash
        @observer = observer
      end

      def ==(other)
        if other.class == Hash
          check_filter(other)
        else
          super
        end
      end

      def check_filter(other)
        if @event_hash.class == Symbol
          case @event_hash
          when :all
            true
          when :all_once
            @observer.remove
            true
          else
            false
          end
        else
          # TODO: add filter logic
          true
        end
      end
    end

  end
end