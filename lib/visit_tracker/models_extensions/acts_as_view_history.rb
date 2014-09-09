#Adds the basic architecture to a ViewHistory model
module VisitTracker
  module ModelsExtensions
    module ActsAsViewHistory

      def self.included(base)
        base.extend         ClassMethods
      end # self.included

      module ClassMethods
        def acts_as_view_history
          return if self.included_modules.include? VisitTracker::ModelsExtensions::ActsAsViewHistory::Methods
          self.send(:include, VisitTracker::ModelsExtensions::ActsAsViewHistory::Methods)
        end
      end # ClassMethods

      module Methods
        extend ActiveSupport::Concern

        included do
          belongs_to  :item, :polymorphic => true
          belongs_to  :view_counter
        end        

        #Returns a hash only with common params in format of a ViewHistory
        def extract_base_of_view_counter(view_counter)
          self.item_type      = view_counter.item_type
          self.item_id        = view_counter.item_id
          self.source         = view_counter.source
          self.view_counter   = view_counter
        end

        module ClassMethods
          def from_view_counter(view_counter)
            view_history = self.new
            view_history.extract_base_of_view_counter(view_counter)
            view_history
          end 
        end
      end
    end
  end
end
