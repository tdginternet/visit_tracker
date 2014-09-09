class CreateViewCounters < ActiveRecord::Migration
  def self.up
    create_table :view_counters do |t|
      t.string  :item_type  , :null    => false
      t.integer :item_id    , :null    => false
      t.integer :today      , :default => 0
      t.integer :yesterday  , :default => 0
      t.integer :this_week  , :default => 0
      t.integer :last_week  , :default => 0
      t.integer :this_month , :default => 0
      t.integer :last_month , :default => 0
      t.integer :total      , :default => 0
      t.string  :source     , :default => 'desktop'
      t.timestamps
    end
    add_index :view_counters, [:item_type, :item_id, :source], :unique => true
    add_index :view_counters, [:item_type, :today]
    add_index :view_counters, [:item_type, :yesterday]
    add_index :view_counters, [:item_type, :this_week]
    add_index :view_counters, [:item_type, :last_week]
    add_index :view_counters, [:item_type, :this_month]
    add_index :view_counters, [:item_type, :last_month]
    add_index :view_counters, [:item_type, :total]
  end

  def self.down
    drop_table :view_counters
  end
end
