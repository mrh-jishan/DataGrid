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

ActiveRecord::Schema[7.0].define(version: 2023_10_08_173412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aggregators", force: :cascade do |t|
    t.bigint "visualization_id"
    t.bigint "csv_header_id"
    t.string "axis"
    t.string "aggregator_function"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_header_id"], name: "index_aggregators_on_csv_header_id"
    t.index ["visualization_id", "csv_header_id", "aggregator_function", "axis"], name: "idx_viz_header_function_axis", unique: true
    t.index ["visualization_id"], name: "index_aggregators_on_visualization_id"
  end

  create_table "csv_headers", force: :cascade do |t|
    t.bigint "file_upload_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aggregate_function", default: "count", null: false
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "visualizations", force: :cascade do |t|
    t.bigint "file_upload_id"
    t.string "chart_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.index ["file_upload_id"], name: "index_visualizations_on_file_upload_id"
  end

end
