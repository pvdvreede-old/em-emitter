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

      def call_action(data, event)
        # only invoke the method if it can be invoked
        if @object.nil? == false && @object.respond_to?(@method) &&
          (@object.method(@method).arity == 2 || @object.method(@method).arity == -1)
          @object.send(@method, data, event)
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