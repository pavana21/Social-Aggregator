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

ActiveRecord::Schema.define(version: 20130914093439) do

  create_table "facebook_profiles", force: true do |t|
    t.integer  "social_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.string   "about"
    t.string   "location"
    t.string   "url"
    t.string   "facebook_oauth_token"
    t.string   "facebook_uid"
    t.string   "access_token"
  end

  create_table "linkedin_profiles", force: true do |t|
    t.integer  "social_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_inbox_feeds", force: true do |t|
    t.string   "feed_id"
    t.string   "tweet_id"
    t.text     "message"
    t.string   "story"
    t.string   "photo"
    t.string   "link"
    t.datetime "created_time"
    t.string   "user_id"
    t.string   "inbox_type"
    t.string   "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "social_id"
    t.datetime "updated_time"
  end

  create_table "socials", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_profiles", force: true do |t|
    t.integer  "social_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "password"
    t.string   "password_confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
