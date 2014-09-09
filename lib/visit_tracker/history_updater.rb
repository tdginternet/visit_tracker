
module VisitTracker
  module HistoryUpdater

    require 'visit_tracker/history_updater/base'
    require 'visit_tracker/history_updater/weekly_updater'

    mattr_reader :history_updaters
    @@history_updaters = {}
   
    # Add an updater to history_updaters of application.
    # The structure of history_updaters is this:
    #
    # { 
    #   DummyItem   => { 
    #                    :monthly => [ MonthlyUpdater ],
    #                    :daily   => [ DailyUpdater ]  
    #                  }, 
    #   Post        => { :weekly  => [ WeeklyUpdater ] } 
    # } 
    def self.add_updaters(updaters, object)
      object_updaters = @@history_updaters[object] || {}
      updaters.each do |period, updater|
        object_updaters[period] ||= []
        object_updaters[period].concat [updater].flatten
      end
      @@history_updaters[object] = object_updaters
    end

    # Returns all updaters of an object or class
    def self.updaters_by_object(object)
      @@history_updaters[object]
    end

    def self.get_updaters_by_period(period)
      @@history_updaters.map { |object| object[period] }.flatten
    end

    #weekly => {object => updater}
    def self.get_updaters_and_objects_by_period(period)
      updaters = {}
      @@history_updaters.map do |object, object_updaters|
        updaters[object] = object_updaters[period].flatten if object_updaters[period]
      end
      updaters
    end

    def self.get_periods
      @@history_updaters.map {|object, updaters| updaters.keys }.flatten.uniq
    end

    private

    def self.clear_history_updaters
      @@history_updaters = {}
    end

  end
end
