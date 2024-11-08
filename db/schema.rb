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

ActiveRecord::Schema[7.1].define(version: 2023_12_21_051029) do
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
    t.bigint "dataset_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aggregate_function", default: "count", null: false
    t.index ["dataset_id"], name: "index_csv_headers_on_dataset_id"
    t.index ["name", "dataset_id"], name: "index_csv_headers_on_name_and_dataset_id", unique: true
  end

  create_table "csv_rows", force: :cascade do |t|
    t.bigint "dataset_id"
    t.jsonb "csv_row", default: {}, null: false
    t.string "unique_by", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dataset_id", "csv_row", "unique_by"], name: "index_csv_rows_on_dataset_id_and_csv_row_and_unique_by", unique: true
    t.index ["dataset_id"], name: "index_csv_rows_on_dataset_id"
  end

  create_table "dashboards", force: :cascade do |t|
    t.bigint "user_id"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dashboards_on_user_id"
  end

  create_table "dashboards_visualizations", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "visualization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_dashboards_visualizations_on_dashboard_id"
    t.index ["visualization_id"], name: "index_dashboards_visualizations_on_visualization_id"
  end

  create_table "data_platforms", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "platform_id"
    t.jsonb "config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_id"], name: "index_data_platforms_on_platform_id"
    t.index ["user_id"], name: "index_data_platforms_on_user_id"
  end

  create_table "data_stream_files", force: :cascade do |t|
    t.bigint "data_stream_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_stream_id"], name: "index_data_stream_files_on_data_stream_id"
  end

  create_table "data_streams", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dataset_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dataset_id"], name: "index_data_streams_on_dataset_id"
    t.index ["user_id"], name: "index_data_streams_on_user_id"
  end

  create_table "datasets", force: :cascade do |t|
    t.string "name"
    t.string "file"
    t.string "file_type"
    t.bigint "file_size"
    t.string "unique_by", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_datasets_on_user_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "short_urls", force: :cascade do |t|
    t.string "shareable_type"
    t.bigint "shareable_id"
    t.string "slug"
    t.datetime "expires_at"
    t.integer "views_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shareable_type", "shareable_id"], name: "index_short_urls_on_shareable"
    t.index ["slug"], name: "index_short_urls_on_slug", unique: true
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
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
    t.string "api_token"
    t.index ["api_token"], name: "index_users_on_api_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "visualizations", force: :cascade do |t|
    t.bigint "dataset_id"
    t.string "chart_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.index ["dataset_id"], name: "index_visualizations_on_dataset_id"
  end

  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
