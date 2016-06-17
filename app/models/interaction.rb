# == Schema Information
#
# Table name: interactions
#
#  id                  :integer          not null, primary key
#  interaction_type_id :integer
#  origin_user_id      :integer          not null
#  target_user_id      :integer
#  tent_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Interaction < ActiveRecord::Base
  belongs_to :interaction_type
  belongs_to :user
  belongs_to :tent
end
