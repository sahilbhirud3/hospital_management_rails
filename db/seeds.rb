# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#name ,address
require "faker"
department_names = [
  "Cardiology",
  "Pediatrics",
  "Oncology",
  "Orthopedics",
  "Neurology",
  "Gynecology",
  "Emergency Medicine",
  "Psychiatry",
  "Radiology",
  "General Surgery",
]
ward_types = [
  "ICU",
  "IICU",
  "Emergency",
  "Surgical",
  "Pediatric",
  "Maternity",
  "Psychiatric",
]

# Department data
# department_names.each do |name|
#   Department.create!(
#     name: name,
#     address: Faker::Address.full_address,
#   )
# end
Faker::UniqueGenerator.clear
#user Data
# 10.times do
#   User.create!(first_name: Faker::Name.first_name,
#                last_name: Faker::Name.last_name,
#                email: Faker::Internet.unique.email,
#                contact: Faker::Number.unique.number(digits: 10),
#                password: 123,
#                role: "user")
# end

#doctor data
# 10.times do
#   user = User.create!(first_name: Faker::Name.first_name,
#                       last_name: Faker::Name.last_name,
#                       email: Faker::Internet.unique.email,
#                       contact: Faker::Number.unique.number(digits: 10),
#                       password: 123,
#                       role: "doctor")
#   fake_start_time = Faker::Time.between_dates(from: Date.today, to: Date.today + 30, period: :morning)
#   DoctorDetail.create!(
#     regno: Faker::  Alphanumeric.unique.alphanumeric(number: 8), # Generates an 8-character alphanumeric string
#     department_id: Faker::Number.between(from: 1, to: 10), # Generates a random number between 1 and 10 (adjust range as needed)
#     start_time: fake_start_time, # Generates a random time within the morning of the next 30 days
#     end_time: Faker::Time.between(from: fake_start_time, to: fake_start_time + 6.hours), # Generates an end time 6 hours after the start time
#     required_time_slot: 15
#     qualification: "MS", # Generates a fake course name
#     user_id: user.id,
#   )
# end

# #bed data
# ward_types.each do |ward_type|
#   10.times do |i|
#     Bed.create!(
#       ward_type: ward_type,
#       bed_no: i + 1,
#       status: "vaccant",
#     )
#   end
# end

# #patient data
# 10.times do
#   fake_gender = %w[Male Female Other].sample
#   if fake_gender == "Male"
#     fake_first_name = Faker::Name.male_first_name
#   elsif fake_gender == "Female"
#     fake_first_name = Faker::Name.female_first_name
#   else
#     fake_first_name = Faker::Name.first_name
#   end
#   fake_last_name = Faker::Name.last_name
#   fake_birthdate = Faker::Date.birthday(min_age: 18, max_age: 90)
#   fake_contact = Faker::Number.unique.number(digits: 10)
#   Patient.create!(first_name: fake_first_name,
#                   last_name: fake_last_name,
#                   gender: fake_gender,
#                   contact: fake_contact,
#                   birthdate: fake_birthdate,
#                   user_id: Faker::Number.between(from: 1, to: 10))
# end

# #ipd
# 10.times do |i|
#   fake_patient = i + 1
#   fake_department = Faker::Number.between(from: 1, to: 10)
#   fake_bed = Faker::Number.between(from: 1, to: 90)
#   fake_status = %w[admitted discharged].sample
#   Bed.find(fake_bed).status = "acquired" if fake_status == "admitted"
#   fake_admission_datetime = Faker::Time.backward(days: 30)

#   if fake_status == "discharged"
#     fake_discharge_datetime = Faker::Time.forward(days: 1)
#   else

#     fake_discharge_datetime = nil
#   end

#   ipd = Ipd.create!(
#     patient_id: fake_patient,
#     department_id: fake_department,
#     bed_id: fake_bed,
#     status: fake_status,
#     admission_datetime: fake_admission_datetime,
#     discharge_datetime: fake_discharge_datetime,
#   )

#   # Calculate datetime range for treatments
#   treatment_start_datetime = fake_admission_datetime
#   treatment_end_datetime = fake_discharge_datetime || DateTime.now

#   4.times do
#     fake_treatment_description = Faker::Lorem.paragraph(sentence_count: 2)
#     fake_treatment_datetime = Faker::Time.between(from: treatment_start_datetime, to: treatment_end_datetime)

#     Treatment.create!(
#       ipd_id: ipd.id,
#       description: fake_treatment_description,
#       datetime: fake_treatment_datetime,
#     )
#   end
# end
#
#
  
