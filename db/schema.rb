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

ActiveRecord::Schema.define(version: 20140114060633) do

  create_table "activities", force: true do |t|
    t.string   "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "status"
    t.text     "activity_name"
    t.text     "sign_up_number"
    t.text     "bid_number"
  end

  create_table "admins", force: true do |t|
    t.text     "name"
    t.text     "password"
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analyses", force: true do |t|
    t.text     "user"
    t.text     "activity_name"
    t.text     "bid_name"
    t.text     "price"
    t.text     "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bid_lists", force: true do |t|
    t.text     "user"
    t.text     "activity_name"
    t.text     "bid_name"
    t.text     "number"
    t.text     "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "sign_up_number"
  end

  create_table "biddings", force: true do |t|
    t.text     "user"
    t.text     "activity_name"
    t.text     "name"
    t.text     "phone"
    t.text     "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bid_name"
  end

  create_table "results", force: true do |t|
    t.text     "user"
    t.text     "activity_name"
    t.text     "bid_name"
    t.text     "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sign_ups", force: true do |t|
    t.text     "activity_name"
    t.text     "name"
    t.text     "phone"
    t.text     "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.text     "name"
    t.text     "password"
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "password_confirmation"
  end

end
