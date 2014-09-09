shared_examples_for :a_history_updater do |updater_class|
  subject { updater_class }
  it { should respond_to(:historify_view_counters).with(1).argument}
  it { should respond_to(:convert_view_counter).with(2).argument}

  context "Class methods" do
    before(:each) do
      dummy_itens = FactoryGirl.create_list(:dummy_item, 5)
    end

    let(:view_counters) { ViewCounter.all }
    let(:view_counter) { view_counters.first }
    let(:expected_histories) {
      expected_histories = Array.new
      view_counters.each do |vc|
        expected_histories << updater_class.convert_view_counter(vc)
      end
      expected_histories
    }

    describe ".historify_view_counters" do
      it "should be implemented" do
        expect{ updater_class.historify_view_counters(view_counters) }.to_not raise_error{ NotImplementedError }
      end
    end

    describe ".generate_history_by_item_type" do
      it "generates history to all ViewCounters belonging a item_type" do
        ignored_attributes = [:id, :created_at, :updated_at]
        view_histories = updater_class.generate_history_by_item_type(view_counter.item_type)
        view_histories.each_with_index do |vh, index|
          vh.attributes.except(*ignored_attributes) == expected_histories[index].attributes.except(*ignored_attributes)
        end
      end
    end

    describe ".generate_history"do
      it "generates history objects based on the ViewCounters only to an item" do
        view_histories = updater_class.generate_history(view_counter.item)
        view_histories.each do |vh|
          expect(vh.item).to eq(view_counter.item)
        end
      end
    end
  end

end
