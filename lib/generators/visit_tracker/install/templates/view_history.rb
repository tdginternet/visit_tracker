class ViewHistory < ActiveRecord::Base
  self.table_name = 'view_history'
  acts_as_view_history
end
