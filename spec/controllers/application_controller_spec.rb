require 'spec_helper'

describe ApplicationController do

  it "should add visits to model" do
    application_controller = ApplicationController.new
    expect( application_controller.respond_to?(:add_visit_for) ).to be_truthy
  end

end
