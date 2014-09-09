module VisitTracker

  class Engine < Rails::Engine
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'lib/tasks/*.rake')].each { |f| load f }
    end
  end

  module ModelsExtensions
    require 'visit_tracker/models_extensions/has_view_counters'
    require 'visit_tracker/models_extensions/has_view_history'
    require 'visit_tracker/models_extensions/has_history_updaters'

    require 'visit_tracker/models_extensions/acts_as_view_counter'
    require 'visit_tracker/models_extensions/acts_as_view_history'
  end

  module ControllersExtensions
    require 'visit_tracker/controllers_extensions/add_visit'
    require 'visit_tracker/controllers_extensions/helpers'
  end

  require 'visit_tracker/visit'
  require 'visit_tracker/history_updater'

end

