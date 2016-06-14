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
#  tent_id     :integer
#

class Post < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :tent
  
  # Scoping
  # Show only non-resolved posts.
  scope :active, -> { where(resolved: false) }
  scope :in_tent, -> (id) { where(tent_id: id) }

  # Callbacks
  # Mark datetime of resolution.
  after_update :mark_resolved_at, :if => :resolved_changed?

  protected
  
    def mark_resolved_at
      self.resolved_at = DateTime.now
    end
end
