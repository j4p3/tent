class PostSerializer < ActiveModel::Serializer
  attributes :id, :headline, :content, :updated_at
  embed :ids, :include => true
  # has_many :tags, key: :tags
  has_many :tags
end
