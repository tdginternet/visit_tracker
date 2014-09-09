#Adds the common behaviors to objects that have an ViewHistory
module VisitTracker 
  module ModelsExtensions
    module HasViewHistory
      def self.included(base)
        base.extend         ClassMethods
      end # self.included

      module ClassMethods

        #Adiciona histórico ao objeto
        def has_view_history
          return if self.included_modules.include? VisitTracker::ModelsExtensions::HasViewHistoryMethods
          self.send(:include, VisitTracker::ModelsExtensions::HasViewHistoryMethods)
        end

      end # ClassMethods 
    end

    module HasViewHistoryMethods
      extend ActiveSupport::Concern

      included do

        #Is a view_history with many parts
        has_many :view_history, :as => :item, :dependent => :destroy
      end
    end

  end
end
