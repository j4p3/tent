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


class InteractionSerializer < ActiveModel::Serializer
  attributes :id, :interaction_type, :updated_at
  has_one :post
  has_one :user
  has_one :target_user
rescue Exception => e
  raise e if Rails.env.development?
end
