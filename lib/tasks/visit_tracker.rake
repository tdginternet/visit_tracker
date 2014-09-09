require "#{File.dirname(__FILE__)}/helpers/schedule.rb"
namespace :visit_tracker do
  namespace :generate_schedule do

    desc "Generates an schedule config to whenever"
    task :whenever => :environment do
      message = ""
      ::VisitTracker::HistoryUpdater::get_periods.map do |period|
        message += Helpers::Schedule.generate_config_for_period(period)
      end

      puts "\n\n\nConf gerada:\n\n\n_________________________________\n #{message}"
      Helpers::Schedule.concat_file("config/schedule.rb", message)
      puts "\n_________________________________
            \nSchedule gerado!
            \nVERIFIQUE O ARQUIVO: config/schedule.rb
            \nLembre de sempre executar visit_tracker:generate_schedule:whenever apos atualizar qualquer updater"
    end

  end
end
