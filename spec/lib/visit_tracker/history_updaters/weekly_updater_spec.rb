require 'spec_helper'
require 'shared_examples'

module VisitTracker
  module HistoryUpdater

    describe WeeklyUpdater do

      it_should_behave_like :a_history_updater, WeeklyUpdater

      let(:dummy_item) { FactoryGirl.create(:dummy_item) }
      let(:view_counter) { dummy_item.view_counters.last }

      describe ".convert_view_counter" do

        it "returns an object ViewHistory based on the ViewCounter object received in param" do
          view_history = WeeklyUpdater.convert_view_counter(view_counter)
          expect(view_history.item_type).to eq(view_counter.item_type)
          expect(view_history.counter_type).to eq('VisitTracker::HistoryUpdater::WeeklyUpdater')
          expect(view_history.start_at).to eq(Date.today.to_time_in_current_zone - 1.week)
          expect(view_history.finish_at).to eq(Date.today.to_time_in_current_zone)
          expect(view_history.views).to eq(view_counter.last_week)
          expect(view_history.source).to eq(view_counter.source)
        end

        it "sets finish_at considering only start_at option" do
          start_at = DateTime.parse('2013-01-06')
          view_history = WeeklyUpdater.convert_view_counter(view_counter, {start_at: start_at})
          expect(view_history.start_at).to eq(start_at)
          expect(view_history.finish_at).to eq(start_at + 1.week)
        end

        it "sets start_at considering only finish_at option" do
          finish_at = DateTime.parse('2013-01-06')
          view_history = WeeklyUpdater.convert_view_counter(view_counter, {finish_at: finish_at})
          expect(view_history.finish_at).to eq(finish_at)
          expect(view_history.start_at).to eq(finish_at-1.week)
        end

      end
    end
  end # HistoryUpdater
end # VisitTracker
