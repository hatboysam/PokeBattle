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

ActiveRecord::Schema.define(:version => 20120915044854) do

  create_table "arguments", :force => true do |t|
    t.integer  "user_id1"
    t.integer  "user_id2"
    t.string   "topic"
    t.string   "textcode"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "argument_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userstatuses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "argument_id"
    t.integer  "health"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.string   "from"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
