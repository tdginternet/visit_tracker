module VisitTracker 
  module ModelsExtensions
    module HasViewCounters

      def self.included(base)
        base.extend         ClassMethods
      end # self.included

      module ClassMethods

        # Adiciona um contador de views ao model
        # *options* eh um hash com as opcoes:
        #   :delay_cache -> Numero de views que serao cacheadas antes de passar para o banco de dados
        #
        def has_view_counters options = {:delay_cache => 10}
          return if self.included_modules.include? VisitTracker::ModelsExtensions::HasViewCountersMethods
          self.send(:include, VisitTracker::ModelsExtensions::HasViewCountersMethods)

          cattr_accessor :views_count_delay_cache
          self.views_count_delay_cache = options[:delay_cache]
        end

      end # ClassMethods
    end

    module HasViewCountersMethods
      extend ActiveSupport::Concern

      included do

        has_many :view_counters, :as => :item, :dependent => :destroy
        
        scope :view_counter_by_source , lambda { |source|  joins(:view_counters).where('view_counters.source = ?', source) }
        scope :order_view_counter     , lambda { |listing| joins(:view_counters).order("#{listing.to_s} DESC") }
        scope :order_today_views      , order_view_counter(:today)
        scope :order_yesterday_views  , order_view_counter(:yesterday)
        scope :order_this_week_views  , order_view_counter(:this_week)
        scope :order_last_week_views  , order_view_counter(:last_week)
        scope :order_this_month_views , order_view_counter(:this_month)
        scope :order_last_month_views , order_view_counter(:last_month)
        scope :order_total_views      , order_view_counter(:total)

        after_create :create_view_counter
      end

      def view_counter
        ActiveSupport::Deprecation.warn "THIS METHOD WAS DELETED, PLEASE USE view_counter_totals INSTEAD"
      end

      # Returns a ViewCounter with the total of visits
      def view_counter_totals

        fields = [:today, :yesterday, :this_week, :last_week, :this_month, :last_month, :total]
        totals = ViewCounter.new()

        ViewCounter.by_item(self).each do |vc|
          fields.each do |field|
            totals.send("#{field}=", totals.send(field) + vc.send(field))
          end
        end
        @totals = totals
      end

      # Cria um contador de views para o model
      #
      def create_view_counter source=nil
        source ||= ViewCounter.default_source
        unless self.view_counters.by_source(source).first
          ViewCounter.create(:item => self, :source => source)
        end
      end

      module ClassMethods

      end

    end
  end
end
 