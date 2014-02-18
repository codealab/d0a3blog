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

ActiveRecord::Schema.define(version: 20140214223057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "addresses", force: true do |t|
    t.string   "calle"
    t.string   "num_ext"
    t.string   "num_int"
    t.string   "localidad"
    t.string   "referencia"
    t.string   "colonia"
    t.string   "municipio"
    t.string   "ciudad"
    t.string   "estado"
    t.string   "pais"
    t.string   "codigo_postal"
    t.string   "telefono"
    t.string   "celular"
    t.string   "email"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "person_id"
    t.integer  "lecture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.string   "area"
    t.integer  "min_age"
    t.integer  "max_age"
    t.text     "objective"
    t.text     "description"
    t.text     "material"
    t.text     "music"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "families", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
    t.integer  "responsible_id"
    t.text     "observations"
  end

  add_index "families", ["name"], name: "index_families_on_name", unique: true, using: :btree

  create_table "family_relations", force: true do |t|
    t.integer  "family_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "location"
    t.integer  "cost"
    t.date     "init_date"
    t.date     "finish_date"
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lectures", force: true do |t|
    t.integer  "group_id"
    t.datetime "date"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "amount",      default: 0
    t.date     "date"
    t.integer  "spot_id"
    t.boolean  "scholarship", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "first_last_name"
    t.string   "second_last_name"
    t.string   "sex"
    t.date     "dob"
    t.string   "family_roll"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["name", "first_last_name", "second_last_name"], name: "index_people_on_name_and_first_last_name_and_second_last_name", unique: true, using: :btree

  create_table "plans", force: true do |t|
    t.integer  "lecture_id"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spots", force: true do |t|
    t.integer  "child_id"
    t.integer  "tutor_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spots", ["child_id", "group_id"], name: "index_spots_on_child_id_and_group_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "employee_roll"
    t.boolean  "coordinator"
    t.boolean  "facilitator"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
