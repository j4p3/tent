# == Schema Information
#
# Table name: tents
#
#  id         :integer          not null, primary key
#  name       :string
#  desc       :string
#  user_id    :integer
#  image      :string
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class TentSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :image, :parent_id
rescue Exception => e
  raise e if Rails.env.development?
end
