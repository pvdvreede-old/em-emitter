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
          filter_match?(other)
        end
      end

      def filter_match?(filter)
        # logic for working out if the filter matches

        # find any items in the event that is not in the filter
        outersect = Hash[@event_hash.to_a - filter.to_a]

        # if there are no elements that dont match we have a match
        return true if outersect.count == 0

        false
      end
    end

  end
end