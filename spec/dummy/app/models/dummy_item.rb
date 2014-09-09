class DummyItem < ActiveRecord::Base

  has_view_counters
  has_view_history
  has_history_updaters :weekly => ::VisitTracker::HistoryUpdater::WeeklyUpdater 
                        
end
