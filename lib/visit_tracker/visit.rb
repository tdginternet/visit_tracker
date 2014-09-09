module VisitTracker

  # Classe para tratar visitas
  #
  class Visit

    # Adiciona uma visita ao model informado
    #
    def self.add_visit_for model, source = 'desktop'
      views_count_now = (Rails.cache.read(counter_cache_key(model, source)) || 0) + 1
      if model.class.views_count_delay_cache <= views_count_now.to_i
        update_counters_for(model, views_count_now.to_i, source)
        Rails.cache.write(counter_cache_key(model, source), 0)
      else
        Rails.cache.write(counter_cache_key(model, source), views_count_now.to_i)
      end
    end


    # Faz um update geral de todos os contadores diarios
    # passando o valor de today para yesterday e zerando today
    #
    def self.daily_update
      scheduled_updates(:daily)
    end

    # Faz um update geral de todos os contadores semanais
    # passando o valor desta semana para a semana passada
    # e zerando a semana passada
    def self.weekly_update
      scheduled_updates(:weekly)
    end

    # Faz um update geral de todos os contadores mensais
    # passando o valor deste mes para o mes passado
    # e zerando o mes passado
    def self.monthly_update
      scheduled_updates(:monthly)
    end

    # Retorna o numero de views pendentes no cache para o modelo
    # Basicamente para debug
    #
    def self.pending_view_counts_for(model, source = 'desktop')
      Rails.cache.read(counter_cache_key(model, source)) || 0
    end

    private

    # Relaiza a atualizacao dos contadores para o *type* informado
    #
    def self.scheduled_updates type = :daily
      counters = ViewCounter.all

      counters.each do |counter|
        counter.update_counter(type)
      end
    end

    # Gera a cache key para as views pendentes do modelo
    #
    def self.counter_cache_key(model, source = 'desktop')
      "view_counter_#{model.class.name}_#{model.id}_#{source}"
    end

    # Atualiza o contador de visitas do *model* com *new_visits* visitas
    #
    def self.update_counters_for(model, new_visits, source = 'desktop')
      ViewCounter.increase_visits(model, new_visits, source)
    end

  end
end
