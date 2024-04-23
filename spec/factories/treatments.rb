# == Schema Information
#
# Table name: treatments
#
#  id          :bigint           not null, primary key
#  ipd_id      :bigint           not null
#  description :text
#  datetime    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :treatment do
    description { "Test Treatment" }
    datetime { DateTime.now }
    association :ipd, factory: :ipd
  end
end
