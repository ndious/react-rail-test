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

ActiveRecord::Schema[7.0].define(version: 2022_05_23_215837) do
  create_table "contracts", force: :cascade do |t|
    t.string "number"
    t.integer "status"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "contracts_options", id: false, force: :cascade do |t|
    t.integer "contract_id", null: false
    t.integer "option_id", null: false
    t.index ["contract_id", "option_id"], name: "index_contracts_options_on_contract_id_and_option_id", unique: true
  end

  create_table "contracts_users", id: false, force: :cascade do |t|
    t.integer "contract_id", null: false
    t.integer "user_id", null: false
    t.index ["contract_id", "user_id"], name: "index_contracts_users_on_contract_id_and_user_id", unique: true
  end

  create_table "options", force: :cascade do |t|
    t.string "identifier"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "role"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

end
