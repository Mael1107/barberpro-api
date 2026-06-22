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

ActiveRecord::Schema[8.1].define(version: 2026_06_01_140815) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "appointment_services", force: :cascade do |t|
    t.bigint "appointment_id", null: false
    t.datetime "created_at", null: false
    t.decimal "price_at_booking"
    t.bigint "service_id", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_appointment_services_on_appointment_id"
    t.index ["service_id"], name: "index_appointment_services_on_service_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "barber_profile_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.text "notes"
    t.datetime "scheduled_at"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["barber_profile_id"], name: "index_appointments_on_barber_profile_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
  end

  create_table "barber_profiles", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "instagram"
    t.string "photo_url"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_barber_profiles_on_user_id", unique: true
  end

  create_table "barber_schedules", force: :cascade do |t|
    t.bigint "barber_profile_id", null: false
    t.datetime "created_at", null: false
    t.time "end_time", null: false
    t.time "start_time", null: false
    t.datetime "updated_at", null: false
    t.integer "weekday", null: false
    t.index ["barber_profile_id", "weekday"], name: "index_barber_schedules_on_barber_profile_id_and_weekday", unique: true
    t.index ["barber_profile_id"], name: "index_barber_schedules_on_barber_profile_id"
  end

  create_table "services", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.integer "duration_minutes"
    t.string "name", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "appointment_services", "appointments"
  add_foreign_key "appointment_services", "services"
  add_foreign_key "appointments", "barber_profiles"
  add_foreign_key "appointments", "users", column: "client_id"
  add_foreign_key "barber_profiles", "users"
  add_foreign_key "barber_schedules", "barber_profiles"
end
