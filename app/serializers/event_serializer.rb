class EventSerializer < ActiveModel::Serializer
  attributes :id, :type
  has_one :user
  has_one :post
rescue Exception => e
  raise e if Rails.env.development?
end
