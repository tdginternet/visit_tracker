shared_examples_for :has_history_updaters do

  let(:dummy_item) {FactoryGirl.create(:dummy_item)}
  let(:view_counter) { dummy_item.view_counters.first}

  it { should respond_to(:generate_history) }

  describe ".generate_history" do

    before { ::VisitTracker::HistoryUpdater.send(:clear_history_updaters) }

    it "calls the generate_history only to the updaters of a period to correct class" do
      mocked_object = double("Object of other class")
      updater_a = double("Updater A")
      
      updater_b = double("Updater B")
      
      weekly_updaters  = [updater_a, updater_b]
      #monthly_updaters = ["lili".stub(:generate_history).with(mocked_object), "lolo".stub(:generate_history).with(mocked_object)]

      ::VisitTracker::HistoryUpdater.add_updaters({:weekly => weekly_updaters}, dummy_item)
      
      updaters = ::VisitTracker::HistoryUpdater.updaters_by_object(dummy_item)
      
      allow(updater_a).to receive(:generate_history).and_return(true)
      allow(updater_b).to receive(:generate_history).and_return(true)

      #updater_a.stub(:generate_history).with(dummy_item).and_return(true)
      #updater_b.stub(:generate_history).with(dummy_item).and_return(true)

      expect(dummy_item.generate_history(:weekly)).to eq(updaters[:weekly])
    end
  end
end
