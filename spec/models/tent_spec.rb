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

require 'rails_helper'

RSpec.describe Tent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
