# == Schema Information
#
# Table name: interaction_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InteractionSerializer < ActiveModel::Serializer
  # @todo just stringify the name
  attributes :id, :name
rescue Exception => e
  raise e if Rails.env.development?
end
