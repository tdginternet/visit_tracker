module VisitTracker
  module ModelsExtensions
    module ActsAsViewCounter
      def self.included(base)
        base.extend         ClassMethods
      end # self.included

      module ClassMethods
        def acts_as_view_counter options = {:default_source => 'desktop'}
          return if self.included_modules.include? VisitTracker::ModelsExtensions::ActsAsViewCounter::Methods
          self.send(:include, VisitTracker::ModelsExtensions::ActsAsViewCounter::Methods)

          cattr_accessor :default_source
          self.default_source = options[:default_source]
        end
      end # ClassMethods

      module Methods
        extend ActiveSupport::Concern

        included do
          belongs_to :item, :polymorphic => true
          has_many   :view_history

          scope :include_item, includes(:item)
          scope :by_source, lambda {|source| where(:source => source)}
          scope :by_item,   lambda {|item| where(:item_type => item.class.to_s, :item_id => item.id)}
          scope :by_item_type, lambda {|item_type| where(:item_type => item_type) }
          scope :order_today_views      , order('today DESC')
          scope :order_yesterday_views  , order('yesterday DESC')
          scope :order_this_week_views  , order('this_week DESC')
          scope :order_last_week_views  , order('last_week DESC')
          scope :order_this_month_views , order('this_month DESC')
          scope :order_last_month_views , order('last_month DESC')
          scope :order_total_views      , order('total DESC')
        end

        module ClassMethods

          # Incrementa as visitas do contador
          # Recebe o model e a quantidade de visitas como parametro
          #
          def increase_visits(model, count = 1, source = 'desktop')
            view_counter = (model.view_counters.by_source(source).first if model.view_counters) || model.send(:create_view_counter, source)
            view_counter.update_attributes({
              :today      => view_counter.today      + count,
              :this_week  => view_counter.this_week  + count,
              :this_month => view_counter.this_month + count,
              :total      => view_counter.total      + count
            }) 
          end
        end

        # Realiza a rotacao das contagens para o *counter_type* informado
        # Opcoes de counter_type por padrao sao:
        #   :daily    -> Rotacao diaria
        #   :weekly   -> Rotacao semanal
        #   :monthly  -> Rotacao mensal
        def update_counter(counter_type)

          column_from, column_to = (
            case counter_type.to_s
            when 'daily'
              ['today', 'yesterday']
            when 'weekly'
              ['this_week', 'last_week']
            when 'monthly'
              ['this_month', 'last_month']
            else
              return false
            end)

            self.send("#{column_to}=", self.send(column_from))
            self.send("#{column_from}=", 0)
            self.save
        end

        # Public: last_view_history
        #
        #
        # Yields ViewHistory
        #
        # Examples
        #
        #   MyViewCounter.last_view_history
        #
        # Returns The last ViewHistory created for this item
        def last_view_history
          self.view_history.last
        end

      end # Methods
    end # AsViewCounter
  end # ModelExtensions
end # VisitTracker