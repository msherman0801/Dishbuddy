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

ActiveRecord::Schema.define(version: 20190222010332) do

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "res_id"
    t.text   "name"
    t.text   "city_name"
    t.text   "address"
    t.string "url"
    t.string "photos_url"
    t.string "aggregate_rating"
    t.string "votes"
    t.text   "locality"
    t.text   "latitude"
    t.text   "longitude"
    t.string "rating_color"
    t.text   "phone_numbers"
  end

  create_table "user_restaurants", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.text    "review"
    t.integer "flag"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.text   "first_name"
    t.text   "last_name"
    t.text   "phone_number"
    t.text   "location"
  end

end
