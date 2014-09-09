ActiveRecord::Base.send(:include, VisitTracker::ModelsExtensions::ActsAsViewHistory)
ActiveRecord::Base.send(:include, VisitTracker::ModelsExtensions::HasViewHistory)
ActiveRecord::Base.send(:include, VisitTracker::ModelsExtensions::HasHistoryUpdaters)
