class Ipd < ApplicationRecord
  belongs_to :patient
  belongs_to :department
  belongs_to :bed
  has_many :treatments
  has_paper_trail
  scope :get_admitted, -> { where(status: "admitted") }
  scope :get_discharged, -> { where(status: "discharged") }
end
