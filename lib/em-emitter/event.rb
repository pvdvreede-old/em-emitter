# Copyright (C) 2012 Paul Van de Vreede
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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