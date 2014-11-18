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

ActiveRecord::Schema.define(version: 20141117172458) do

  create_table "announcements", force: true do |t|
    t.boolean  "active"
    t.string   "context"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appcolors", force: true do |t|
    t.integer  "value"
    t.string   "tag"
    t.string   "context"
    t.string   "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applingos", force: true do |t|
    t.text     "line"
    t.string   "context"
    t.string   "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cartitems", force: true do |t|
    t.integer  "cart_id"
    t.integer  "item_id"
    t.integer  "review_quality_rating"
    t.integer  "review_quantity_rating"
    t.text     "review_comment"
    t.float    "quantity"
    t.integer  "price"
    t.string   "item_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cartitems", ["cart_id"], name: "index_cartitems_on_cart_id"
  add_index "cartitems", ["item_id"], name: "index_cartitems_on_item_id"

  create_table "carts", force: true do |t|
    t.integer  "restaurant_id"
    t.string   "restaurant_name"
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "club_id"
    t.string   "club_status"
    t.datetime "expires"
    t.float    "bill_amount"
    t.float    "service_tax"
    t.float    "vat"
    t.float    "other_tax"
    t.string   "building_no"
    t.string   "area"
    t.string   "city"
    t.integer  "pincode"
    t.string   "contact"
    t.text     "address"
    t.string   "lock"
    t.string   "status"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["club_id"], name: "index_carts_on_club_id"
  add_index "carts", ["restaurant_id"], name: "index_carts_on_restaurant_id"
  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubchats", force: true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.integer  "cart_id"
    t.text     "message"
    t.integer  "likes"
    t.integer  "dislike"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clubchats", ["cart_id"], name: "index_clubchats_on_cart_id"
  add_index "clubchats", ["club_id"], name: "index_clubchats_on_club_id"
  add_index "clubchats", ["user_id"], name: "index_clubchats_on_user_id"

  create_table "clubs", force: true do |t|
    t.integer  "clubid"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.integer  "master_cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clubs", ["user_id"], name: "index_clubs_on_user_id"

  create_table "items", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "category_id"
    t.integer  "restaurant_id"
    t.integer  "rating"
    t.string   "photo_url"
    t.time     "time_start_avail"
    t.time     "time_end_avail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id"
  add_index "items", ["restaurant_id"], name: "index_items_on_restaurant_id"

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.text     "about"
    t.integer  "min_bill"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "photo_url"
    t.float    "rating"
    t.integer  "rating_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.string   "image"
    t.string   "phone"
    t.string   "address"
    t.string   "email"
    t.integer  "guid"
    t.string   "first_name"
    t.string   "last_name"
  end

end
