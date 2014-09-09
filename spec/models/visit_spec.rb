require 'spec_helper'

describe VisitTracker::Visit do

  it "should add_a_visit to a model" do
    item	 = FactoryGirl.create(:dummy_item)
    view_counter = item.view_counters.first
    today	 = view_counter.today
    this_week	 = view_counter.this_week
    this_month	 = view_counter.this_month

    VisitTracker::Visit.add_visit_for(item)
    new_view_counter = ViewCounter.find(view_counter.id)
    expect(new_view_counter.today).to eq(today)
    expect(new_view_counter.this_week).to eq(this_week)
    expect(new_view_counter.this_month).to eq(this_month)
    
    item.class.views_count_delay_cache.times do
      VisitTracker::Visit.add_visit_for(item)
    end
   	
    new_view_counter = ViewCounter.find(view_counter.id)
    expect(new_view_counter.today).to eq(today      + item.class.views_count_delay_cache)
    expect(new_view_counter.this_week).to eq(this_week  + item.class.views_count_delay_cache)
    expect(new_view_counter.this_month).to eq(this_month + item.class.views_count_delay_cache)
  end

end
