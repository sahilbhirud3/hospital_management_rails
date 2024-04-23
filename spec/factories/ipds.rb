# == Schema Information
#
# Table name: ipds
#
#  id                    :bigint           not null, primary key
#  patient_id            :bigint           not null
#  department_id         :bigint           not null
#  treatment_description :string
#  admission_datetime    :datetime
#  discharge_datetime    :datetime
#  bed_id                :bigint           not null
#  status                :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
FactoryBot.define do
  factory :ipd do
    admission_datetime { DateTime.now }
    status { "admitted" }
    association :patient
    association :bed
    association :department
  end
end
