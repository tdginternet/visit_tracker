module VisitTracker
  module HistoryUpdater
    class WeeklyUpdater < Base


      # Public: Converts an array of ViewCounter in an other array of ViewHistory, savin the ViewHistories in database
      #
      # view_counters  - An array of ViewCounters
      #
      # Returns an array with the "historified" ViewCounters (ViewHistory)
      def self.historify_view_counters(view_counters)
        histories = Array.new
        view_counters.each do |view_counter|
          histories << convert_view_counter(view_counter)
          histories.last.save
        end
        histories
      end

      # Public: Converts a ViewCounter in a ViewHistory
      #
      # view_counter  - The ViewCounter object that will be converted in a ViewHistory.
      # options - A hash of options like:
      #           :start_at - Date that starts the period of history
      #           :finish_at - Date that ends the period of history
      #           :views - Number of views of a ViewHistory
      #
      # Examples
      #
      #   convert_view_counter(view_counter, {start_at: Date.parse('2014-01-13')})
      #   # => ViewHistory<start_at: '2014-01-13 00:00:00', finish_at: '2014-01-20 00:00:00', ..>
      #
      # Note: It is in a WEEKLY UPDATER, so when you set only start_at, or only finish_at, 
      # the other date is calculated automatically by system considering a period that 1 week between the dates.
      #
      # Returns a ViewHistory object, based on the ViewCounter attributes, and the options
      def self.convert_view_counter(view_counter, options = {})
        if options[:start_at] && !options[:finish_at]
          options[:finish_at] = options[:start_at] + 1.week
        end

        if options[:finish_at] && !options[:start_at]
          options[:start_at] = options[:finish_at] - 1.week
        end

        history               = ViewHistory.from_view_counter(view_counter)
        history.counter_type  = WeeklyUpdater.name
        history.start_at      = options.fetch(:start_at, Date.today - 1.week) 
        history.finish_at     = options.fetch(:finish_at, history.start_at + 1.week) 
        history.views         = options.fetch(:views, view_counter.last_week)
        history
      end

    end
  end
end # VisitTracker