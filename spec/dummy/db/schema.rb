# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130513133618) do

  create_table "dummy_items", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "view_counters", :force => true do |t|
    t.string   "item_type",                         :null => false
    t.integer  "item_id",                           :null => false
    t.integer  "today",      :default => 0
    t.integer  "yesterday",  :default => 0
    t.integer  "this_week",  :default => 0
    t.integer  "last_week",  :default => 0
    t.integer  "this_month", :default => 0
    t.integer  "last_month", :default => 0
    t.integer  "total",      :default => 0
    t.string   "source",     :default => "desktop"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "view_counters", ["item_type", "item_id", "source"], :name => "index_view_counters_on_item_type_and_item_id_and_source", :unique => true
  add_index "view_counters", ["item_type", "last_month"], :name => "index_view_counters_on_item_type_and_last_month"
  add_index "view_counters", ["item_type", "last_week"], :name => "index_view_counters_on_item_type_and_last_week"
  add_index "view_counters", ["item_type", "this_month"], :name => "index_view_counters_on_item_type_and_this_month"
  add_index "view_counters", ["item_type", "this_week"], :name => "index_view_counters_on_item_type_and_this_week"
  add_index "view_counters", ["item_type", "today"], :name => "index_view_counters_on_item_type_and_today"
  add_index "view_counters", ["item_type", "total"], :name => "index_view_counters_on_item_type_and_total"
  add_index "view_counters", ["item_type", "yesterday"], :name => "index_view_counters_on_item_type_and_yesterday"

  create_table "view_history", :force => true do |t|
    t.string   "item_type",                           :null => false
    t.integer  "item_id",                             :null => false
    t.string   "counter_type",                        :null => false
    t.datetime "start_at",                            :null => false
    t.datetime "finish_at",                           :null => false
    t.integer  "views",        :default => 0
    t.string   "source",       :default => "desktop"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "view_history", ["item_type", "item_id", "source"], :name => "index_view_history_on_item_type_and_item_id_and_source"
  add_index "view_history", ["item_type", "item_id", "start_at", "finish_at"], :name => "history_period"
  add_index "view_history", ["item_type", "views"], :name => "index_view_history_on_item_type_and_views"

end
