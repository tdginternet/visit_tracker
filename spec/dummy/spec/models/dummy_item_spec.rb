require 'spec_helper'
require 'shared_examples'

describe DummyItem do
  
  it_should_behave_like :has_history_updaters
  it_should_behave_like :has_view_history
  it {should have_many  :view_counters}

  it "should have a valid class" do
    expect(FactoryGirl.build(:dummy_item)).to be_valid
  end

  it "should create an view_counter on create" do
    item = DummyItem.create
    expect(item.view_counters.first).not_to be_nil
  end

  describe "#view_counter_totals" do
    it "should return a view_counter with the total of views" do
      item = FactoryGirl.create(:dummy_item)
      item.create_view_counter(:mobile)

      vc_one = item.view_counters.first
      vc_two = item.view_counters.last
      vc_one.today = vc_one.this_week = vc_one.total = 10
      vc_two.today = vc_two.this_week = vc_two.total = 20
      vc_one.save
      vc_two.save

      totals = item.view_counter_totals

      expect(totals.today).to eq(30)
      expect(totals.this_week).to eq(30)
      expect(totals.total).to eq(30)
    end
  end

  describe "#create_view_counter" do
    it "should create a view_counter" do
      item = FactoryGirl.create(:dummy_item)
      item.view_counters.first.destroy if item.view_counters.first
      item.reload
      expect(item.view_counters.first).to be_nil
      item.create_view_counter
      
      item = DummyItem.find(item.id)
      expect(item.view_counters.first).not_to be_nil
    end
  end



  

end
