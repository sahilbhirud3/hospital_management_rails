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
class Bed < ApplicationRecord
  WARD_TYPES = [
    "ICU",
    "IICU",
    "Emergency",
    "Surgical",
    "Pediatric",
    "Maternity",
    "Psychiatric",
  ]
  validates :ward_type, :bed_no, presence: true
  validates :ward_type, inclusion: { in: WARD_TYPES, message: "%{value} is invalid ward type" }
  validates :status, inclusion: { in: %w(vaccant acquired unavailable), message: "%{value} is invalid ward type" }
  before_validation :set_default_status, on: :create
  has_many :ipds
  has_paper_trail
  scope :get_vaccant, -> { where(status: "vaccant") }
  scope :get_acquired, -> { where(status: "acquired") }

  private

  def set_default_status
    self.status ||= "vaccant"
  end
end
