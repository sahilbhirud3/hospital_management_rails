# == Schema Information
#
# Table name: treatments
#
#  id          :bigint           not null, primary key
#  ipd_id      :bigint           not null
#  description :text
#  datetime    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class TreatmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
