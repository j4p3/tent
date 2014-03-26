class TagSerializer < ActiveModel::Serializer
  attributes :id, :title
  embed :ids, :include => true
  has_many :posts
rescue Exception => e
  raise e if Rails.env.development?
end
