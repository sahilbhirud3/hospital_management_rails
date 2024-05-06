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
class Department < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }, uniqueness: true
  validates :address, presence: true, length: { maximum: 255 }
  # has_many :doctor_details
end
  