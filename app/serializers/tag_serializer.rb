# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

class TagSerializer < ActiveModel::Serializer
  attributes :id, :title
  embed :ids, :include => true
  has_many :posts
rescue Exception => e
  raise e if Rails.env.development?
end
