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
require "test_helper"

class BedTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
