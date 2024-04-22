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
require "test_helper"

class DoctorDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
