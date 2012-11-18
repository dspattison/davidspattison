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

ActiveRecord::Schema.define(:version => 20121113025520) do

  create_table "facebook_users", :force => true do |t|
    t.integer  "app_id",      :null => false
    t.integer  "facebook_id", :null => false
    t.string   "auth",        :null => false
    t.string   "email",       :null => false
    t.string   "name"
    t.integer  "status",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_users", ["email"], :name => "index_facebook_users_on_email"
  add_index "facebook_users", ["facebook_id", "app_id"], :name => "index_facebook_users_on_facebook_id_and_app_id", :unique => true

  create_table "spaste_pastes", :force => true do |t|
    t.text     "body"
    t.string   "title"
    t.string   "public_key"
    t.string   "version"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spaste_pastes", ["public_key"], :name => "index_spaste_pastes_on_public_key"

  create_table "tte_games", :force => true do |t|
    t.string   "player_a_email"
    t.string   "player_b_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tte_turns", :force => true do |t|
    t.integer  "game_id"
    t.integer  "number"
    t.integer  "board"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urlshorts", :force => true do |t|
    t.string   "target_url"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "urlshorts", ["code"], :name => "index_urlshorts_on_code", :unique => true

end
