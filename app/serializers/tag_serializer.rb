# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TagSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :posts
rescue Exception => e
  raise e if Rails.env.development?
end
