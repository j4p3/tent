
class InteractionSerializer < ActiveModel::Serializer
  attributes :id, :interaction_type, :created_at
  has_one :post
  has_one :user
  has_one :tent
rescue Exception => e
  raise e if Rails.env.development?
end
