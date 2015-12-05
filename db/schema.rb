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

ActiveRecord::Schema.define(version: 20151024205824) do

  create_table "deals", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "food_name",   limit: 255
    t.text     "description", limit: 65535
    t.string   "address",     limit: 255
    t.string   "deal_type",   limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "food_type",   limit: 255
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "views",       limit: 4,     default: 0
    t.integer  "shares",      limit: 4,     default: 0
    t.integer  "purchases",   limit: 4,     default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "email",               limit: 255
    t.string   "password_digest",     limit: 255
    t.string   "food_type",           limit: 255
    t.string   "address",             limit: 255
    t.string   "phone_number",        limit: 255
    t.string   "hours",               limit: 255
    t.string   "delivery",            limit: 255
    t.float    "latitude",            limit: 24
    t.float    "longitude",           limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "website",             limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

end
