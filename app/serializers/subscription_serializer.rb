# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :post
rescue Exception => e
  raise e if Rails.env.development?
end
