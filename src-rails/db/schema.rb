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

ActiveRecord::Schema[7.0].define(version: 2022_05_15_211401) do
  create_table "contract_clients", force: :cascade do |t|
    t.integer "user_id"
    t.integer "contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_contract_clients_on_contract_id"
    t.index ["user_id"], name: "index_contract_clients_on_user_id"
  end

  create_table "contract_options", force: :cascade do |t|
    t.string "identifier"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.string "number"
    t.string "status"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contract_option_id", null: false
    t.index ["contract_option_id"], name: "index_contracts_on_contract_option_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "contract_clients", "contracts"
  add_foreign_key "contract_clients", "users"
  add_foreign_key "contracts", "contract_options"
end
