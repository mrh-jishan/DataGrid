# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_30_223341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "csv_headers", force: :cascade do |t|
    t.bigint "file_upload_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "data_type", default: "string", null: false
    t.index ["file_upload_id"], name: "index_csv_headers_on_file_upload_id"
  end

  create_table "csv_rows", force: :cascade do |t|
    t.bigint "file_upload_id"
    t.jsonb "csv_row", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_row", "file_upload_id"], name: "index_csv_rows_on_csv_row_and_file_upload_id", unique: true
    t.index ["file_upload_id"], name: "index_csv_rows_on_file_upload_id"
  end

  create_table "file_uploads", force: :cascade do |t|
    t.string "name"
    t.string "file"
    t.string "file_type"
    t.bigint "file_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
