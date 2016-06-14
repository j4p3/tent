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

ActiveRecord::Schema.define(version: 20160610204922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interaction_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interactions", force: :cascade do |t|
    t.integer  "interaction_type_id"
    t.integer  "origin_user_id",      null: false
    t.integer  "target_user_id"
    t.integer  "tent_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "interactions", ["interaction_type_id"], name: "index_interactions_on_interaction_type_id", using: :btree
  add_index "interactions", ["origin_user_id"], name: "index_interactions_on_origin_user_id", using: :btree
  add_index "interactions", ["target_user_id"], name: "index_interactions_on_target_user_id", using: :btree
  add_index "interactions", ["tent_id"], name: "index_interactions_on_tent_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["tent_id"], name: "index_memberships_on_tent_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "headline",    limit: 255
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resolved",                default: false
    t.datetime "resolved_at"
    t.integer  "user_id"
    t.integer  "tent_id"
  end

  add_index "posts", ["tent_id"], name: "index_posts_on_tent_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["title"], name: "index_tags_on_title", unique: true, using: :btree

  create_table "tents", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "user_id"
    t.string   "image"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tents", ["parent_id"], name: "index_tents_on_parent_id", using: :btree
  add_index "tents", ["user_id"], name: "index_tents_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                limit: 255, default: "", null: false
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",   limit: 255
    t.string   "last_sign_in_ip",      limit: 255
    t.string   "provider",             limit: 255
    t.string   "uid",                  limit: 255
    t.string   "facebook_token",       limit: 255
    t.string   "authentication_token", limit: 255
    t.string   "name",                 limit: 255
    t.string   "avatar",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link",                 limit: 255
    t.string   "password_digest"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "interactions", "interaction_types"
  add_foreign_key "interactions", "tents"
  add_foreign_key "tents", "users"
end
