module EM
  module Emitter
    module Caller
      def emit(event, object)
        EM::Emitter.emit(self, event, object)
        self
      end

      def receiver(event, method_name)
        EM::Emitter.add_observer(self, event, method_name)
        self
      end
    end
  end
end