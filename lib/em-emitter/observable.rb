module EM
  module Emitter
    module Observable

      def uses_clone(cloner)
        @uses_clone = cloner
      end

      def emit(event, object)
        # check and see if the observer uses cloning
        if @uses_clone
          object = clone_data(object)
        end

        EM::Emitter.emit(self, event, object)
        self
      end

      def receiver(event, method_name)
        EM::Emitter.add_observer(self, event, method_name)
        self
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