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

ActiveRecord::Schema.define(version: 20130901150629) do

  create_table "agents", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
  end

  create_table "clients", force: true do |t|
    t.text     "comments"
    t.string   "file_number"
    t.text     "source"
    t.string   "company"
    t.date     "date_received"
    t.boolean  "confirmed"
    t.integer  "individual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",         precision: 2, scale: 0
  end

  add_index "clients", ["individual_id"], name: "index_clients_on_individual_id"

  create_table "individuals", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "phone"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leases", force: true do |t|
    t.integer  "client_id"
    t.decimal  "rental_amount"
    t.string   "move_out"
    t.string   "date"
    t.date     "move_in"
    t.boolean  "welcome_home"
    t.boolean  "thank_you_sent"
    t.date     "dropped_date"
    t.text     "comments"
    t.decimal  "referral_amount"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "agent_id"
  end

  add_index "leases", ["agent_id"], name: "index_leases_on_agent_id"
  add_index "leases", ["client_id"], name: "index_leases_on_client_id"
  add_index "leases", ["property_id"], name: "index_leases_on_property_id"

  create_table "properties", force: true do |t|
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "notes"
    t.integer  "individual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["individual_id"], name: "index_properties_on_individual_id"

  create_table "rooms", force: true do |t|
    t.integer  "property_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "room_number"
  end

  add_index "rooms", ["property_id"], name: "index_rooms_on_property_id"

  create_table "sales", force: true do |t|
    t.integer  "agent_id"
    t.boolean  "hear"
    t.integer  "individual_id"
    t.integer  "property_id"
    t.date     "closing_date"
    t.string   "company"
    t.string   "office_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "buyer_id"
    t.integer  "broker_id"
  end

  add_index "sales", ["agent_id"], name: "index_sales_on_agent_id"
  add_index "sales", ["individual_id"], name: "index_sales_on_individual_id"
  add_index "sales", ["property_id"], name: "index_sales_on_property_id"

  create_table "tenants", force: true do |t|
    t.integer  "individual_id"
    t.date     "leased_signed"
    t.date     "lease_expired"
    t.integer  "property_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenants", ["individual_id"], name: "index_tenants_on_individual_id"
  add_index "tenants", ["property_id"], name: "index_tenants_on_property_id"
  add_index "tenants", ["room_id"], name: "index_tenants_on_room_id"

  create_table "tours", force: true do |t|
    t.integer  "agent_id"
    t.integer  "client_id"
    t.date     "date"
    t.integer  "room_id"
    t.text     "comments"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tours", ["agent_id"], name: "index_tours_on_agent_id"
  add_index "tours", ["client_id"], name: "index_tours_on_client_id"
  add_index "tours", ["property_id"], name: "index_tours_on_property_id"
  add_index "tours", ["room_id"], name: "index_tours_on_room_id"

end
