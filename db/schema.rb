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

ActiveRecord::Schema[7.0].define(version: 2024_05_22_215548) do
  create_table "accounts", force: :cascade do |t|
    t.string "account_number"
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amount_transactions", force: :cascade do |t|
    t.integer "account_id", null: false
    t.float "amount"
    t.string "transaction_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_amount_transactions_on_account_id"
  end

  add_foreign_key "amount_transactions", "accounts"
end
