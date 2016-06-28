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
#  post_id             :integer
#

class Interaction < ActiveRecord::Base
  # Relations
  belongs_to :interaction_type
  belongs_to :user, foreign_key: 'origin_user_id'
  belongs_to :target_user, class_name: 'User', foreign_key: 'target_user_id'
  belongs_to :tent
  belongs_to :post

  # Scopes
  # targeted at user
  scope :for, -> (user) {
    includes(:post, :user, :interaction_type).where(target_user_id: user.id)
  }
end
