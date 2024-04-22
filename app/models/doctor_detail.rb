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
class DoctorDetail < ApplicationRecord
  validates :regno, :department_id, :start_time, :end_time, :required_time_slot, :qualification, presence: true
  validates :regno, uniqueness: true
  validate :validate_required_time_slot
  validates :qualification, length: { maximum: 255 }
  # app/models/your_model.rb

  def validate_required_time_slot
    if !(required_time_slot >= 10 && (required_time_slot % 60 == 0 || 60 % required_time_slot == 0))
      errors.add(:required_time_slot, "must be 10 or more like (15,20,30,60)  ")
    end
  end

  belongs_to :user
  belongs_to :department
end
