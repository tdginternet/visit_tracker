module VisitTracker
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def generate_migrations
        begin
          migration_template "create_view_counters.rb", "db/migrate/create_view_counters.rb"
          migration_template "create_view_history.rb",  "db/migrate/create_view_history.rb"
        rescue Exception => e
          puts e.message
        end
      end

      def gems
        begin
          gem('googlecharts')
        rescue Exception => e
          puts e.message
        end
      end

      def gererate_model
        copy_file "view_counter.rb", "app/models/view_counter.rb"
        copy_file "view_history.rb", "app/models/view_history.rb"
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

    end
  end
end


