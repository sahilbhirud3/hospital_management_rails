# == Schema Information
#
# Table name: appointments
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  doctor_id           :bigint
#  patient_id          :bigint           not null
#  slot_start_datetime :datetime
#  slot_end_datetime   :datetime
#  appointment_type    :string
#  status              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
