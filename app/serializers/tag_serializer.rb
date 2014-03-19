class TagSerializer < ActiveModel::Serializer
  attributes :id, :title
  embed :ids, :include => true
  has_many :posts
end
