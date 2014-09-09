module VisitTracker
  module ControllersExtensions
    module AddVisit
      extend ActiveSupport::Concern

      module ClassMethods

      end # ClassMethods

      # Adiciona uma visita ao modelo
      # Verica por session, se o usuário já não visitou este modelo
      #
      def add_visit_for(model)
        return false unless verify_and_update_view_counter_for(model)

        VisitTracker::Visit.add_visit_for(model)
        true
      end

      private

      # Verifica na session do usuário por uma visita ao modelo
      # Caso o usuário não tenha visita, adiciona uma visita na session e retorna true
      #
      def verify_and_update_view_counter_for(model)
        view_counters = session[:view_counter] || {}
        if view_counters["#{model.class.name}"] and view_counters["#{model.class.name}"]["#{model.id}"]
          false
        else
          view_counters["#{model.class.name}"] = Hash.new unless view_counters["#{model.class.name}"]
          view_counters["#{model.class.name}"]["#{model.id}"] = true
          session[:view_counter] = view_counters
          true
        end
      end

    end
  end
end
