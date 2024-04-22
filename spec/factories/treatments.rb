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
  end
end
