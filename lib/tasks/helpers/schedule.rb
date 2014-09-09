module Helpers
  module Schedule

    #Receives a period in symbol format, and returns another symbol, based on the WHENEVER rules.
    def self.whenever_period(period)
      case period
      when :daily
        ":day"
      when :weekly
        ":sunday"
      when :monthly
        ":month"
      else
        "(PUT HERE THE PERIOD THAT YOU WANT)"
      end
    end

    #Concats a file with a any content
    def self.concat_file(file_name, content)
      file_content = File.exist?(file_name) ? File.read(file_name) : ''
      File.open(file_name, "w+") do |f|
        f.write(file_content+content)
      end
    end

    #Generates the whenever config for a period, and an array of updaters
    def self.generate_config_for_period period
      message = ""
      message += "every #{whenever_period(period)} do \n"
      ::VisitTracker::HistoryUpdater::get_updaters_and_objects_by_period(period).map do |object, object_updaters|
        object_updaters.each {|object_updater| message += "   #{object_updater}.generate_history_by_item_type(#{object}) \n" } if object_updaters 
      end
      message += "end\n\n" 
    end

  end
end
