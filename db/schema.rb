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

ActiveRecord::Schema.define(version: 2019_02_05_140614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_divisions_on_company_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.text "recurring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "machine_id"
    t.index ["machine_id"], name: "index_events_on_machine_id"
  end

  create_table "floors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "division_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_floors_on_company_id"
    t.index ["division_id"], name: "index_floors_on_division_id"
  end

  create_table "issue_reports", force: :cascade do |t|
    t.string "name"
    t.bigint "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_issue_reports_on_issue_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "fixed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "machine_id"
    t.integer "issue_type"
    t.boolean "critical", default: false
    t.decimal "amount", precision: 10, scale: 2
    t.index ["machine_id"], name: "index_issues_on_machine_id"
  end

  create_table "lines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "floor_id"
    t.bigint "division_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_lines_on_company_id"
    t.index ["division_id"], name: "index_lines_on_division_id"
    t.index ["floor_id"], name: "index_lines_on_floor_id"
  end

  create_table "machineries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "machine_id"
    t.bigint "line_id"
    t.bigint "division_id"
    t.bigint "floor_id"
    t.bigint "company_id"
    t.bigint "position_id"
    t.index ["company_id"], name: "index_machineries_on_company_id"
    t.index ["division_id"], name: "index_machineries_on_division_id"
    t.index ["floor_id"], name: "index_machineries_on_floor_id"
    t.index ["line_id"], name: "index_machineries_on_line_id"
    t.index ["machine_id"], name: "index_machineries_on_machine_id"
    t.index ["position_id"], name: "index_machineries_on_position_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "part_number"
    t.text "comment"
    t.boolean "is_working"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_data"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "event_id"
    t.string "body"
    t.date "due_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_notifications_on_event_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "division_id"
    t.bigint "line_id"
    t.index ["division_id"], name: "index_positions_on_division_id"
    t.index ["line_id"], name: "index_positions_on_line_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "name"
    t.string "rank"
    t.string "duty"
    t.text "comment"
    t.integer "title", default: 0
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  add_foreign_key "divisions", "companies"
  add_foreign_key "events", "machines"
  add_foreign_key "floors", "companies"
  add_foreign_key "floors", "divisions"
  add_foreign_key "issue_reports", "issues"
  add_foreign_key "issues", "machines"
  add_foreign_key "lines", "companies"
  add_foreign_key "lines", "divisions"
  add_foreign_key "lines", "floors"
  add_foreign_key "machineries", "companies"
  add_foreign_key "machineries", "divisions"
  add_foreign_key "machineries", "floors"
  add_foreign_key "machineries", "lines"
  add_foreign_key "machineries", "machines"
  add_foreign_key "machineries", "positions"
  add_foreign_key "notifications", "events"
  add_foreign_key "positions", "divisions"
  add_foreign_key "positions", "lines"
  add_foreign_key "users", "companies"
end
