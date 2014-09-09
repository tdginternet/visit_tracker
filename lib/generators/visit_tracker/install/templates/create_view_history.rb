class CreateViewHistory < ActiveRecord::Migration
  def self.up
    create_table :view_history do |t|
      t.string    :item_type  , :null     => false
      t.integer   :item_id    , :null     => false
      t.integer   :view_counter_id, :null => false
      t.string    :counter_type , :null     => false
      t.datetime  :start_at     , :null     => false
      t.datetime  :finish_at    , :null     => false
      t.integer   :views        , :default  => 0
      t.string    :source       , :default  => 'desktop'
      t.timestamps
    end
    add_index :view_history, [:item_type, :item_id, :source, :view_counter_id]
    add_index :view_history, [:item_type, :views]
    add_index :view_history, [:item_type, :item_id, :start_at, :finish_at], :name => 'history_period'
  end

  def self.down
    drop_table :view_history
  end
end
