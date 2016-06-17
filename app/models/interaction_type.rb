# == Schema Information
#
# Table name: interaction_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InteractionType < ActiveRecord::Base
  # Base values:
  # 'close'
  #     Close a post. Nonsensical until we have a reference for a post here :/
  # 
  # 'value'
  #     Assign voice to a user while closing a post
  # 
  # 'ping'
  #     Notify a user of availability in reference to a post
  # 
end
