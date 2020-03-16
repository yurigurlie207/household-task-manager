# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_26_190204) do

  create_table "subtasks", force: :cascade do |t|
    t.string "title"
    t.integer "estimated_duration"
    t.integer "actual_duration"
    t.date "deadline"
    t.string "priority"
    t.text "notes"
    t.text "feedback"
    t.integer "task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.integer "estimated_duration"
    t.date "deadline"
    t.string "priority"
    t.text "notes"
  end

  create_table "user_tasks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subtask_id"
    t.datetime "time_created"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.text "email"
    t.string "password_digest"
    t.string "firstname"
    t.string "lastname"
    t.string "role"
    t.date "birthdate"
  end

end
