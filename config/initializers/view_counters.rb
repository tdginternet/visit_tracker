ActiveRecord::Base.send(:include, VisitTracker::ModelsExtensions::ActsAsViewCounter)
ActiveRecord::Base.send(:include, VisitTracker::ModelsExtensions::HasViewCounters)

ActionController::Base.send(:include, VisitTracker::ControllersExtensions::AddVisit)
ActionController::Base.helper(VisitTracker::ControllersExtensions::Helpers)
