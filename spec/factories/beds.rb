# == Schema Information
#
# Table name: beds
#
#  id         :bigint           not null, primary key
#  ward_type  :string
#  bed_no     :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :bed do
    ward_type { Bed::WARD_TYPES.sample }
    bed_no { Faker::Number.unique.number(digits: 3) }
    status { "vaccant"}
  end
end
