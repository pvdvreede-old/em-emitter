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
    module Observable

      attr_reader :receivers
      # TODO: pass event along with data to methods

      def uses_clone(cloner)
        @uses_clone = cloner
      end

      def emit(event, object)
        # check and see if the observer uses cloning
        if @uses_clone
          object = clone_data(object)
        end

        EM::Emitter.emit(event, object)
        self
      end

      def receiver(event, method_name)
        @receivers ||= []
        @receivers << EM::Emitter.add_observer(self, event, method_name)
        self
      end

      def remove_receivers!
        @receivers.each { |rec| EM::Emitter.remove_observer(rec) }
        @receivers = []
      end

      def clone_data(object)
        # clone or copy depending on type
        if object.nil?
          clone_obj = nil
        elsif object.respond_to?(:clone)
          clone_obj = object.clone
        elsif object.respond_to?(:dup)
          clone_obj = object.dup
        else
          clone_obj = object
        end

        clone_obj
      end
    end
  end
end