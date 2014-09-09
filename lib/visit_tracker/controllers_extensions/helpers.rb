# encoding: utf-8
module VisitTracker
  module ControllersExtensions
    module Helpers
      extend ActiveSupport::Concern

      def image_view_counters_url_for(item, options = {})
        view_counter = item.view_counter_totals || ViewCounter.new  
        options.reverse_merge!({
          :size => '700x200',
          :title => 'Historico de Visitas',
          :legend => ["Hoje (#{view_counter.today})", "Ontem (#{view_counter.yesterday})", "Esta Semana (#{view_counter.this_week})", "Semana Passada (#{view_counter.last_week})", "Este Mês (#{view_counter.this_month})","Mês Passado (#{view_counter.last_month})", "Total (#{view_counter.total})"],
          :bar_colors => ['FF0000','990000','00FF00','009900','0000FF','000099','FF00FF'],
          :data => [[view_counter.today], [view_counter.yesterday], [view_counter.this_week], [view_counter.last_week], [view_counter.this_month], [view_counter.last_month], [view_counter.total]],
          :stacked => false
        })
        Gchart.bar(options).html_safe
      end


    end
  end
end
