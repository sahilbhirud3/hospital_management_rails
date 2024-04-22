# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  contact         :string
#  password        :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    contact { Faker::Number.unique.number(digits: 10) }
    password { 123 }
    role { "user" }
  end
end
