require 'spec_helper'

describe ViewCounter do
  it "should have a valid factory" do
    expect(FactoryGirl.build(:view_counter)).to be_valid
  end

  it {should belong_to :item}

  let(:item) {FactoryGirl.create(:dummy_item)}

  it "should update_views_counters" do
    view_counter = item.view_counters.first
    today	 = view_counter.today
    yesterday	 = view_counter.yesterday
    this_week	 = view_counter.this_week
    last_week	 = view_counter.last_week
    this_month	 = view_counter.this_month
    last_month	 = view_counter.last_month

    view_counter.update_counter(:daily)
    view_counter = ViewCounter.find view_counter.id
    expect(view_counter.today).to eq(0)
    expect(view_counter.yesterday).to eq(yesterday + today)

    view_counter.update_counter(:weekly)
    view_counter = ViewCounter.find view_counter.id
    expect(view_counter.this_week).to eq(0)
    expect(view_counter.last_week).to eq(yesterday + today)

    view_counter.update_counter(:monthly)
    view_counter = ViewCounter.find view_counter.id
    expect(view_counter.this_month).to eq(0)
    expect(view_counter.this_month).to eq(yesterday + today)
  end
end
