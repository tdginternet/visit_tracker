shared_examples_for :acts_as_view_history do |history_class|
  it { should respond_to(:extract_base_of_view_counter) }
  it { should belong_to(:item) }

  let(:view_counter) {FactoryGirl.create(:view_counter, :item_type => "Lalal", :item_id => 20, :source => "Desktop")}

  describe ".from_view_counter" do
    it "creates a new view history based on a view counter" do
      my_history = history_class.from_view_counter(view_counter)
      expect(my_history.item_type).to eq(view_counter.item_type)
      expect(my_history.item_id).to eq(view_counter.item_id)
      expect(my_history.source).to eq(view_counter.source)
    end
  end

  describe "#extract_base_of_view_counter" do
    it "sets the common attributes between view_counters and view_histories, independently of type of updayter" do
      my_history = history_class.new
      my_history.extract_base_of_view_counter(view_counter)
      expect(my_history.item_type).to eq(view_counter.item_type)
      expect(my_history.item_id).to eq(view_counter.item_id)
      expect(my_history.source).to eq(view_counter.source)
    end
  end
end
