
module VisitTracker
  module HistoryUpdater
    # The base to create an updater
    #
    class Base

      # Generates all histories based on the item_type
      def self.generate_history_by_item_type(item_type)
        view_counters = ViewCounter.by_item_type(item_type)
        historify_view_counters(view_counters)
      end

      # Generates a ViewHistory based on an item
      def self.generate_history(item)
        view_counters = ViewCounter.by_item(item)
        historify_view_counters(view_counters)
      end

      # This method should take the view_counters generate their history
      # returning an array with the created histories
      def self.historify_view_counters(view_counters)
        raise NotImplementedError.new("You must implement the historify_view_counters in your updater class.")
      end
    end
  end
end
