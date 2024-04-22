# == Schema Information
#
# Table name: ipds
#
#  id                    :bigint           not null, primary key
#  patient_id            :bigint           not null
#  department_id         :bigint           not null
#  treatment_description :string
#  admission_datetime    :datetime
#  discharge_datetime    :datetime
#  bed_id                :bigint           not null
#  status                :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Ipd < ApplicationRecord
  belongs_to :patient
  belongs_to :department
  belongs_to :bed
  has_many :treatments
  has_paper_trail
  scope :get_admitted, -> { where(status: "admitted") }
  scope :get_discharged, -> { where(status: "discharged") }
end
