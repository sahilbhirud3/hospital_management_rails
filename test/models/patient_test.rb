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
require "test_helper"

class PatientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
