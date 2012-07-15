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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120714070145) do

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "coaches_teams", :force => true do |t|
    t.integer  "coach_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string  "title"
    t.string  "term"
    t.string  "department"
    t.integer "crn"
    t.string  "status"
    t.string  "subject"
    t.string  "sect"
    t.string  "credit"
    t.string  "instructor"
    t.string  "bldg"
    t.string  "day"
    t.time    "start_time"
    t.time    "end_time"
    t.date    "from"
    t.date    "to"
    t.string  "fee"
  end

  create_table "event_types", :force => true do |t|
    t.string  "name"
    t.integer "category_id"
  end

  create_table "events", :force => true do |t|
    t.string   "title",         :default => "", :null => false
    t.integer  "event_type_id"
    t.datetime "starts_at",                     :null => false
    t.datetime "ends_at",                       :null => false
    t.text     "description"
    t.integer  "user_id",                       :null => false
    t.integer  "with",          :default => 0,  :null => false
    t.integer  "related_id",    :default => 0,  :null => false
    t.integer  "course_id",     :default => 0,  :null => false
    t.integer  "read_only",     :default => 0
  end

  create_table "profiles", :force => true do |t|
    t.text     "information"
    t.text     "reviews"
    t.string   "email"
    t.integer  "mobile_number"
    t.string   "landline_number"
    t.string   "website"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_invites", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.boolean  "activate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_courses", :force => true do |t|
    t.string "student_id"
    t.string "course_id"
  end

  create_table "users_teams", :force => true do |t|
    t.integer  "student_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
