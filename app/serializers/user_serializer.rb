class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :link
rescue Exception => e
  raise e if Rails.env.development?
end