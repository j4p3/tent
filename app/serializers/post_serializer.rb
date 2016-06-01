# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  headline    :string
#  content     :text
#  created_at  :datetime
#  updated_at  :datetime
#  resolved    :boolean          default(FALSE)
#  resolved_at :datetime
#  user_id     :integer
#

class PostSerializer < ActiveModel::Serializer
  attributes :id, :headline, :content, :updated_at
  embed :ids, :include => true
  has_many :tags
  has_one :user
rescue Exception => e
  raise e if Rails.env.development?
end
