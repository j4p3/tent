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
#

class Post < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :tags
  
  # Scoping
  # Show only non-resolved posts.
  scope :active, -> { where(resolved: false) }

  # Callbacks
  # Mark datetime of resolution.
  after_update :mark_resolved_at, :if => :resolved_changed?

  private
  
      def mark_resolved_at
        self.resolved_at = DateTime.now
      end
end
