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

ActiveRecord::Schema[8.1].define(version: 2026_03_24_112310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "blood_banks", force: :cascade do |t|
    t.string "address", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "hospital_id"
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "pincode", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "state", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified", default: false
    t.string "website"
    t.index ["email"], name: "index_blood_banks_on_email", unique: true
    t.index ["hospital_id"], name: "index_blood_banks_on_hospital_id"
    t.index ["reset_password_token"], name: "index_blood_banks_on_reset_password_token", unique: true
  end

  create_table "blood_requests", force: :cascade do |t|
    t.boolean "allowed_to_users"
    t.bigint "blood_bank_id"
    t.string "blood_group"
    t.datetime "created_at", null: false
    t.bigint "hospital_id", null: false
    t.integer "quantity"
    t.string "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["blood_bank_id"], name: "index_blood_requests_on_blood_bank_id"
    t.index ["hospital_id"], name: "index_blood_requests_on_hospital_id"
    t.index ["user_id"], name: "index_blood_requests_on_user_id"
  end

  create_table "blood_stocks", force: :cascade do |t|
    t.bigint "blood_bank_id", null: false
    t.string "blood_group", null: false
    t.datetime "created_at", null: false
    t.integer "quantity", null: false
    t.datetime "updated_at", null: false
    t.index ["blood_bank_id"], name: "index_blood_stocks_on_blood_bank_id"
  end

  create_table "donation_appointments", force: :cascade do |t|
    t.bigint "blood_bank_id", null: false
    t.datetime "created_at", null: false
    t.date "scheduled_date"
    t.time "scheduled_time_end"
    t.time "scheduled_time_start"
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["blood_bank_id"], name: "index_donation_appointments_on_blood_bank_id"
    t.index ["user_id"], name: "index_donation_appointments_on_user_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "address", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "pincode", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "state", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified", default: false
    t.string "website"
    t.index ["email"], name: "index_hospitals_on_email", unique: true
    t.index ["reset_password_token"], name: "index_hospitals_on_reset_password_token", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.integer "mobile"
    t.string "name"
    t.string "password"
    t.string "photo_url"
    t.string "provider"
    t.string "uid"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "address"
    t.string "blood_group"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number"
    t.string "pincode"
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "state"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "blood_banks", "hospitals"
  add_foreign_key "blood_requests", "blood_banks"
  add_foreign_key "blood_requests", "hospitals"
  add_foreign_key "blood_requests", "users"
  add_foreign_key "blood_stocks", "blood_banks"
  add_foreign_key "donation_appointments", "blood_banks"
  add_foreign_key "donation_appointments", "users"
end
