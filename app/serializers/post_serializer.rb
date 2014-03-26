class PostSerializer < ActiveModel::Serializer
  attributes :id, :headline, :content, :updated_at
  embed :ids, :include => true
  has_many :tags
  has_one :user
rescue Exception => e
  raise e if Rails.env.development?
end
