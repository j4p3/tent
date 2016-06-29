class EventSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :type, :type_content
  has_one :post
  has_one :user
rescue Exception => e
  raise e if Rails.env.development?
end
