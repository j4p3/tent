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

ActiveRecord::Schema.define(version: 20140220232954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gid"
    t.string   "organization"
    t.string   "phone"
    t.string   "address"
    t.string   "place"
    t.text     "etag"
    t.string   "email"
    t.string   "avatar"
    t.text     "notes"
    t.datetime "deleted_at"
  end

  create_table "contacts_events", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "contact_id"
  end

  create_table "contacts_tags", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "contact_id"
  end

  create_table "contacts_tasks", id: false, force: true do |t|
    t.integer "contact_id"
    t.integer "task_id"
  end

  create_table "events", force: true do |t|
    t.text     "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gid"
    t.text     "etag"
    t.text     "description"
    t.text     "link"
    t.string   "location"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean  "recurring"
    t.string   "recurring_event_id"
    t.string   "calendar_title"
    t.string   "calendar_id"
    t.datetime "deleted_at"
    t.boolean  "is_orphan",          default: true
  end

  create_table "events_tags", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "event_id"
  end

  create_table "events_tasks", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "task_id"
  end

  create_table "extended_properties", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "headline"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resolved"
    t.datetime "resolved_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "tags_tasks", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "task_id"
  end

  create_table "tasks", force: true do |t|
    t.text     "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "self_link"
    t.string   "notes"
    t.boolean  "status",         default: false
    t.string   "gid"
    t.text     "etag"
    t.datetime "due"
    t.string   "tasklist_title"
    t.string   "tasklist_id"
    t.datetime "deleted_at"
    t.boolean  "is_orphan",      default: true
  end

  create_table "users", force: true do |t|
    t.string   "email",                default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "avatar"
    t.string   "access_token"
    t.string   "refresh_token"
    t.boolean  "is_admin"
    t.boolean  "has_pulled",           default: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
