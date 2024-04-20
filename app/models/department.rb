class Department < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }, uniqueness: true
  validates :address, presence: true, length: { maximum: 255 }
  # has_many :doctor_details
end
