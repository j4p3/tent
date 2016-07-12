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

require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class Post < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :tent
  has_many :users, through: :subscriptions

  # Attributes
  attr_accessor :last_message
  
  # Scoping
  # only non-resolved posts.
  scope :active, -> { where(resolved: false) }
  scope :in_tent, -> (id) { where(tent_id: id) }
  # in tents the user belongs to
  scope :for, -> (user) { where(tent_id: user.memberships.pluck(:tent_id)) }
  # @todo posts order by message recency & limit. Gonna be tricky bridging this fucking gap. Will need node queue.
  scope :subbed, -> (user) { where(id: user.subscriptions.pluck(:post_id)) }

  # Callbacks
  # Mark datetime of resolution.
  after_update :mark_resolved_at, :if => :resolved_changed?
  after_create :subscribe

  def friendly_created_at
    time_ago_in_words(self.created_at)
  end

  def friendly_updated_at
    time_ago_in_words(self.updated_at)
  end

  def request_last_message
    fb_repo = TentApi::Application.config.clients.firebase_repo
    fb_root = TentApi::Application.config.clients.firebase_root
    firebase = Firebase::Client.new("https://#{fb_repo}.firebaseio.com/#{fb_root}/tents/#{self.tent_id}/posts/#{self.id}")

    # &nil negates the '.json' this client appends to all requests :/
    r = firebase.get('stream.json?orderBy="created_at"&limitToLast=1&nil')
    if r.body
      b = r.body.flatten
      @last_message = {
        created_at: b[1]['created_at'],
        text: b[1]['text'],
        user: b[1]['user'].symbolize_keys,
        device: b[1]['device'],
        image: b[1]['image']['uri']
      }
    end
    self
  end

  protected
  
    def mark_resolved_at
      self.resolved_at = DateTime.now
    end

    def subscribe
      self.user.subscriptions.create(post: self)
    end
end
