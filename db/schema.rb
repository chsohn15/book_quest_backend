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

ActiveRecord::Schema.define(version: 2020_10_13_232036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "ISBN_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_url"
    t.integer "total_pages"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "book_id"
  end

  create_table "reading_tweets", force: :cascade do |t|
    t.integer "student_book_id"
    t.text "submission"
    t.integer "point_value"
    t.string "difficulty_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "character_id"
  end

  create_table "student_books", force: :cascade do |t|
    t.integer "student_id"
    t.integer "book_id"
    t.boolean "currently_reading"
    t.integer "total_pages"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "character_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "password_digest"
    t.string "is_student"
    t.bigint "teacher_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "streak", default: 0
    t.index ["teacher_id"], name: "index_users_on_teacher_id"
  end

  create_table "vocab_activities", force: :cascade do |t|
    t.integer "student_book_id"
    t.string "word"
    t.text "definition"
    t.text "sentence_from_book"
    t.text "original_sentence"
    t.text "original_sentence_2"
    t.text "analysis"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "point_value"
  end

end
