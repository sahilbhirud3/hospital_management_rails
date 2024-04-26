# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :department do
    name { Faker::Company.department }
    address { "2nd Floor" }
  end
end
