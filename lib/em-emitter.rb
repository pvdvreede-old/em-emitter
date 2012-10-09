$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'eventmachine'
require 'em-emitter/event'
require 'em-emitter/observer'
require 'em-emitter/observable'
require 'em-emitter/emitter'

module EM
  module Emitter
    # Exception classes
    class MaxObserversReachedException < Exception


    end
  end
end