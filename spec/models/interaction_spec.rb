# == Schema Information
#
# Table name: interactions
#
#  id                  :integer          not null, primary key
#  interaction_type_id :integer
#  origin_user_id      :integer          not null
#  target_user_id      :integer
#  tent_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Interaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
