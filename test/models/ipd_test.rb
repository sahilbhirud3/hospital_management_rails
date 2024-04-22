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
require "test_helper"

class IpdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
