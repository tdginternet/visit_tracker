#Adds the commom behaviors to objects that have ViewUpdaters
module VisitTracker 
  module ModelsExtensions
    module HasHistoryUpdaters
      def self.included(base)
        base.extend         ClassMethods
      end # self.included

      module ClassMethods

        # Add an updater to the object.
        # You can set the period that the updater will be called and the name of the updater like:
        # has_history_updaters :daily => ViewUpdaters::DailyUpdater,
        #                      :weekly => ViewUpdaters::WeeklyUpdater,
        #                      :monthly => ViewUpdaters::MonthlyUpdater, 
        #                      :my_period => MyUpdater
        def has_history_updaters updaters
          return if self.included_modules.include? VisitTracker::ModelsExtensions::HasHistoryUpdatersMethods
          self.send(:include, VisitTracker::ModelsExtensions::HasHistoryUpdatersMethods)
          ::VisitTracker::HistoryUpdater.add_updaters(updaters, self)
        end

      end # ClassMethods 
    end

    module HasHistoryUpdatersMethods
      extend ActiveSupport::Concern

      included do
      end

      #Returns a history to an object, calling all the updaters considering the wanted period.
      #The period is configured on model, like:
      #has_history_updaters   :weekly => ViewUpdaters::WeeklyUpdater, 
      #                       :monthly => ViewUpdaters::MonthlyUpdater
      #To call, this method, considering the examples above, you can use, for example: 
      #                       generate_history(:weekly)
      def generate_history period
        #Loads only the updaters for the wanted period
        updaters = ::VisitTracker::HistoryUpdater.updaters_by_object(self)
        updaters[period].each do |history_updater|
          history_updater.generate_history(self)
        end if updaters[period]
        updaters[period]
      end

    end
  end
end
