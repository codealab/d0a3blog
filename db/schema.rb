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

ActiveRecord::Schema.define(version: 20140715220953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "post_type_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_post_types", force: true do |t|
    t.integer  "category_id"
    t.integer  "post_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_post_types", ["category_id", "post_type_id"], name: "index_categories_post_types_on_category_id_and_post_type_id", unique: true, using: :btree

  create_table "comments", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.text     "text"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_posts", force: true do |t|
    t.integer  "media_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_posts", ["media_id", "post_id"], name: "index_media_posts_on_media_id_and_post_id", unique: true, using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_categories", force: true do |t|
    t.integer  "category_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_categories", ["category_id", "post_id"], name: "index_post_categories_on_category_id_and_post_id", unique: true, using: :btree

  create_table "post_tags", force: true do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_tags", ["post_id", "tag_id"], name: "index_post_tags_on_post_id_and_tag_id", unique: true, using: :btree

  create_table "post_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "cover"
    t.text     "text"
    t.boolean  "main",         default: false
    t.boolean  "status",       default: false
    t.integer  "views",        default: 0
    t.integer  "post_type_id"
    t.integer  "user_id"
    t.text     "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "photo"
    t.text     "bio"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "organization_id"
    t.boolean  "administrator",   default: false
    t.boolean  "writer",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
