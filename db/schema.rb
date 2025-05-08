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

ActiveRecord::Schema[7.1].define(version: 2025_04_23_184430) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounting_objects", force: :cascade do |t|
    t.string "name_object", limit: 64
    t.bigint "user_id", null: false
    t.bigint "type_object_id", null: false
    t.bigint "kind_of_object_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind_of_object_id"], name: "index_accounting_objects_on_kind_of_object_id"
    t.index ["type_object_id"], name: "index_accounting_objects_on_type_object_id"
    t.index ["user_id"], name: "index_accounting_objects_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name_category", limit: 64
    t.bigint "accounting_object_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounting_object_id"], name: "index_categories_on_accounting_object_id"
  end

  create_table "kind_of_objects", force: :cascade do |t|
    t.string "name_kind", limit: 64
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.bigint "accounting_object_id", null: false
    t.bigint "category_id", null: false
    t.datetime "data_stamp"
    t.decimal "amount_of_money", precision: 10, scale: 2
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounting_object_id"], name: "index_operations_on_accounting_object_id"
    t.index ["category_id"], name: "index_operations_on_category_id"
  end

  create_table "type_objects", force: :cascade do |t|
    t.string "name_type", limit: 64
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", limit: 64
    t.string "email", limit: 254
    t.string "password_digest"
    t.string "remember_token_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "accounting_objects", "kind_of_objects"
  add_foreign_key "accounting_objects", "type_objects"
  add_foreign_key "accounting_objects", "users"
  add_foreign_key "categories", "accounting_objects"
  add_foreign_key "operations", "accounting_objects"
  add_foreign_key "operations", "categories"
end
