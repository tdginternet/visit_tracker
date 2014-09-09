
FactoryGirl.define do 

  #WARNING!!! The dummy_item uses the has_view_counter, so, after created, automatically the object creates her view_counter
  factory :view_counter do 
    association :item, :factory => :dummy_item
    today         { |t| Random.rand(100) }
    yesterday     { |t| Random.rand(100) }
    this_week     { |t| t.today + t.yesterday }
    last_week     { |t| Random.rand(300) }
    this_month    { |t| t.this_week + t.last_week }
    last_month    { |t| Random.rand(500) }
    total         { |t| t.this_month + t.last_month }
    source        { |t| "desktop" }
  end

  factory :view_history do
    item_type     'DummyItem' 
    counter_type    'WeeklyUpdater'
    start_at        { Date.today - 1.week }
    finish_at       { Date.today }
    views           { |t| Random.rand(500) }
    source          'desktop'
  end

  factory :dummy_item do
  end
end
