require 'spec_helper'

describe ViewHistory do
  it "should have a valid factory" do
    expect(FactoryGirl.build(:view_history)).to be_valid
  end
end
