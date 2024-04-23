# == Schema Information
#
# Table name: appointments
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  doctor_id           :bigint
#  patient_id          :bigint           not null
#  slot_start_datetime :datetime
#  slot_end_datetime   :datetime
#  appointment_type    :string
#  status              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :appointment do
    association :user
    association :patient
    doctor { create(:doctor_user) } # Assuming you have a Doctor factory defined
    slot_start_datetime { DateTime.now }
    slot_end_datetime { DateTime.now + 30.minutes }
    status { "scheduled" }
    appointment_type { "followup" }
  end
end
