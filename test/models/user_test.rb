# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  contact         :string
#  password        :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
