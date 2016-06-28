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

class Post < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :tent
  has_many :users, through: :subscriptions
  
  # Scoping
  # only non-resolved posts.
  scope :active, -> { where(resolved: false) }
  scope :in_tent, -> (id) { where(tent_id: id) }
  # in tents the user belongs to
  scope :for, -> (user) { where(tent_id: user.memberships.pluck(:tent_id)) }

  # Callbacks
  # Mark datetime of resolution.
  after_update :mark_resolved_at, :if => :resolved_changed?
  after_create :subscribe

  def top_message
    fb_repo = TentApi::Application.config.clients.firebase_repo
    fb_root = TentApi::Application.config.clients.firebase_root
    firebase = Firebase::Client.new("https://#{fb_repo}.firebaseio.com/#{fb_root}/tents/#{self.tent_id}/posts/#{self.id}")

    # &nil negates the '.json' this client appends to all requests :/
    r = firebase.get('stream.json?orderBy="created_at"&limitToLast=1&nil')
    b = r.body.flatten
    {
      text: b[1]['text'],
      user: b[1]['user'].symbolize_keys
    }
  end

  protected
  
    def mark_resolved_at
      self.resolved_at = DateTime.now
    end

    def subscribe
      self.user.subscriptions.create(post: self)
    end
end
