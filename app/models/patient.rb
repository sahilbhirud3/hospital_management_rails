# == Schema Information
#
# Table name: patients
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  birthdate  :date
#  gender     :string
#  contact    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
class Patient < ApplicationRecord
  validates :first_name, :last_name, :birthdate, :gender, :contact, presence: true
  validates :first_name, :last_name, length: { maximum: 25 }
  validate :validate_birthdate
  validates :gender, inclusion: { in: %w(Male Female Other), message: "%{value} is not a valid gender" }
  validates :contact, length: { maximum: 10 }
  belongs_to :user

  private

  def validate_birthdate
    if birthdate.present? && birthdate > Date.today && birthdate < 120.years.ago
      errors.add(:birthdate, "Invalid Birthdate")
    end
  end
end
