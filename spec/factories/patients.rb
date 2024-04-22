# == Schema Information
#
# Table name: patients
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  birthdate  :date
#  gender     :string
#  contact    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
FactoryBot.define do
  factory :patient do
    user { create(:user) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { Faker::Gender.binary_type }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 90) }
    contact { Faker::Number.unique.number(digits: 10) }
    user_id { user.id }
  end
end
