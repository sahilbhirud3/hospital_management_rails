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
class Treatment < ApplicationRecord
  belongs_to :ipd
end
