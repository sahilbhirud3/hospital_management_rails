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

ActiveRecord::Schema[7.1].define(version: 2024_04_16_083109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "doctor_id"
    t.bigint "patient_id", null: false
    t.datetime "slot_start_datetime"
    t.datetime "slot_end_datetime"
    t.string "appointment_type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "beds", force: :cascade do |t|
    t.string "ward_type"
    t.string "bed_no"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctor_details", force: :cascade do |t|
    t.string "regno"
    t.bigint "department_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.integer "required_time_slot"
    t.string "qualification"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_doctor_details_on_department_id"
    t.index ["user_id"], name: "index_doctor_details_on_user_id"
  end

  create_table "ipds", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "department_id", null: false
    t.string "treatment_description"
    t.datetime "admission_datetime"
    t.datetime "discharge_datetime"
    t.bigint "bed_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bed_id"], name: "index_ipds_on_bed_id"
    t.index ["department_id"], name: "index_ipds_on_department_id"
    t.index ["patient_id"], name: "index_ipds_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "gender"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "treatments", force: :cascade do |t|
    t.bigint "ipd_id", null: false
    t.text "description"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ipd_id"], name: "index_treatments_on_ipd_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "contact"
    t.string "password"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "users"
  add_foreign_key "appointments", "users", column: "doctor_id"
  add_foreign_key "doctor_details", "departments"
  add_foreign_key "doctor_details", "users"
  add_foreign_key "ipds", "beds"
  add_foreign_key "ipds", "departments"
  add_foreign_key "ipds", "patients"
  add_foreign_key "patients", "users"
  add_foreign_key "treatments", "ipds"
end
