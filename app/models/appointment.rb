class Appointment < ApplicationRecord
  validates :user_id, :doctor_id, :patient_id, :slot_start_datetime, :slot_end_datetime, :appointment_type, :status, presence: true
  validates :appointment_type, inclusion: { in: %w(checkup followup), message: "%{value} is not a valid appointment type" }
  validates :status, inclusion: { in: %w(checked scheduled cancelled), message: "%{value} is not a valid status" }
  before_validation :set_default_status, on: :create
  belongs_to :user
  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
  belongs_to :patient

  private

  def set_default_status
    self.status ||= "scheduled"
  end
end
