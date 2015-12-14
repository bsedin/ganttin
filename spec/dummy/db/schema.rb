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

ActiveRecord::Schema.define(version: 20151214195756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "project_members", force: :cascade do |t|
    t.string "user_id",    null: false
    t.string "project_id", null: false
    t.string "roles",                   array: true
  end

  add_index "project_members", ["project_id"], name: "index_project_members_on_project_id", using: :btree
  add_index "project_members", ["user_id"], name: "index_project_members_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.integer  "tasks_count"
    t.integer  "members_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "task_members", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "task_id", null: false
    t.string "roles",                array: true
  end

  add_index "task_members", ["task_id"], name: "index_task_members_on_task_id", using: :btree
  add_index "task_members", ["user_id"], name: "index_task_members_on_user_id", using: :btree

  create_table "task_stages", force: :cascade do |t|
    t.string   "title"
    t.string   "task_id",                null: false
    t.integer  "duration",   default: 0, null: false
    t.integer  "overdue",    default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "task_stages", ["task_id"], name: "index_task_stages_on_task_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "number",     default: 1, null: false
    t.string   "project_id"
    t.string   "title"
    t.string   "body"
    t.integer  "time_spent", default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "priority",   default: 0, null: false
  end

  add_index "tasks", ["project_id", "number"], name: "index_tasks_on_project_id_and_number", using: :btree
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name",                   default: "", null: false
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "authentication_token"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "project_members", "projects"
  add_foreign_key "project_members", "users"
  add_foreign_key "task_members", "tasks"
  add_foreign_key "task_members", "users"
  add_foreign_key "task_stages", "tasks"
  add_foreign_key "tasks", "projects"
end
