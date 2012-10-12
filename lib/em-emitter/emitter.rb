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
    @@observers = []
    @@max_listeners = 50

    def self.max_listeners
      @@max_listeners
    end

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

      # emit a system event that an observer has been added with the observer and the listener count
      EM::Emitter::emit({
        :from => '_emitter',
        :action => 'add_observer'
      }, {
        :observer => observer,
        :listeners_count => @@observers.count
      })

      observer
    end

    def self.remove_observer(observer)
      @@observers.delete_if { |x| x == observer }

      # emit a system event that an observer has been remove with the observer and the listener count
      EM::Emitter::emit({
        :from => '_emitter',
        :action => 'remove_observer'
      }, {
        :observer => observer,
        :listeners_count => @@observers.count
      })
    end

    def self.clear_observers!
      @@observers = []

      # emit a system event that all observers have been removed
      EM::Emitter::emit({
        :from => '_emitter',
        :action => 'clear_observers'
      }, {
        :listeners_count => @@observers.count
      })

      @@observers.count
    end

    def self.emit(event, data)
      @@observers.each do |ob|
        if ob.is_active && ob.event == event
          # make the observer method calls async
          EM.next_tick do
            # call the method on the object with the data
            ob.call_action(data, event)
          end
        end
      end

      # remove non active items
      @@observers.delete_if { |x| x.is_active == false }
    end
  end
end