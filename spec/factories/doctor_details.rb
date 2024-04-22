# == Schema Information
#
# Table name: doctor_details
#
#  id                 :bigint           not null, primary key
#  regno              :string
#  department_id      :bigint           not null
#  start_time         :time
#  end_time           :time
#  required_time_slot :integer
#  qualification      :string
#  user_id            :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :doctor_detail do
    department { create(:department) }
    regno { Faker::Alphanumeric.unique.alphanumeric(number: 8) }
    start_time { DateTime.now }
    end_time { DateTime.now + 30.minutes }
    qualification { "MS" }
    required_time_slot { 15 }
  end
end
