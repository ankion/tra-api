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

ActiveRecord::Schema.define(version: 20130904063340) do

  create_table "car_classes", force: true do |t|
    t.string   "no"
    t.string   "name"
    t.string   "en_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.string   "no"
    t.string   "name"
    t.string   "en_name"
    t.string   "ticket_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tai_train_lists", force: true do |t|
    t.string   "train_date"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_infos", force: true do |t|
    t.integer  "train_info_id"
    t.string   "arr_time"
    t.string   "dep_time"
    t.string   "order"
    t.string   "route"
    t.string   "station"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_infos", ["train_info_id"], name: "index_time_infos_on_train_info_id", using: :btree

  create_table "train_infos", force: true do |t|
    t.integer  "tai_train_list_id"
    t.string   "car_class"
    t.string   "cripple"
    t.string   "dinning"
    t.string   "line"
    t.string   "line_dir"
    t.string   "note"
    t.string   "over_night_stn"
    t.string   "package"
    t.string   "route"
    t.string   "train"
    t.string   "train_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "train_infos", ["tai_train_list_id"], name: "index_train_infos_on_tai_train_list_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
