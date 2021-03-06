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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141211131343) do

  create_table "attachments", force: true do |t|
    t.string  "filename"
    t.string  "content_type"
    t.binary  "data"
    t.integer "task_id"
  end

  create_table "attendees", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.boolean  "participate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_weight"
    t.boolean  "answered"
  end

  create_table "comments", force: true do |t|
    t.text     "text"
    t.string   "username"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", force: true do |t|
    t.integer  "selectdate_id"
    t.integer  "user_id"
    t.boolean  "attend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selectdates", force: true do |t|
    t.datetime "task_date"
    t.integer  "attendee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "participate"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "username"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
