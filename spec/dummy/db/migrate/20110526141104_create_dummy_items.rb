class CreateDummyItems < ActiveRecord::Migration
  def self.up
    create_table :dummy_items do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :dummy_items
  end
end
