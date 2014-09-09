class VisitController < ActionController::Base
  protect_from_forgery
  def show
    @model = DummyItem.find(params[:id])
    add_visit_for(@model)
  end

end
