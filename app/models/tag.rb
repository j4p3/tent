# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
    has_and_belongs_to_many :posts
end
