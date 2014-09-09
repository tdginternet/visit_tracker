require 'spec_helper'

module VisitTracker

  describe HistoryUpdater do

    let(:dummy) {FactoryGirl.create(:dummy_item)}

    before(:each) do
      HistoryUpdater.send(:clear_history_updaters)
    end

    describe ".add_updaters" do
      it "adds updaters correctly" do
        first_updaters = {:weekly => "lala", :monthly => ["lele"]} 
        second_updaters = {:monthly => ["lulu"]}
        HistoryUpdater.add_updaters(first_updaters, dummy)
        HistoryUpdater.add_updaters(second_updaters, dummy)
        expected_updaters = { :weekly => ["lala"], :monthly => ["lele", "lulu"] }
        expect(HistoryUpdater.updaters_by_object(dummy)).to eq(expected_updaters)
      end
    end

    describe ".updaters_by_object" do
      it "returns the correct updaters to an object" do
        test_object = double("A test object")
        HistoryUpdater.add_updaters({:weekly => "lala", :monthly => "lele"}, dummy)
        HistoryUpdater.add_updaters({:weekly => "test lala", :monthly => "test lele"}, test_object)
        expect(HistoryUpdater.updaters_by_object(dummy)).to eq({:weekly => ["lala"], :monthly => ["lele"]})
        expect(HistoryUpdater.updaters_by_object(test_object)).to eq({:weekly => ["test lala"], :monthly => ["test lele"]})
      end
    end
  end
end # VisitTracker
