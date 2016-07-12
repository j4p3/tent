# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  headline    :string(255)
#  content     :text
#  created_at  :datetime
#  updated_at  :datetime
#  resolved    :boolean          default(FALSE)
#  resolved_at :datetime
#  user_id     :integer
#  tent_id     :integer
#

class PostSerializer < ActiveModel::Serializer
  attributes :id, :headline, :content, :friendly_created_at, :tent_id
  has_one :tent
  has_one :user
rescue Exception => e
  raise e if Rails.env.development?
end
