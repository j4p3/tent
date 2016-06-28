# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :post


  def self.new_for(user)
    # subscribed posts and their most recent messages
    # @todo posts order by message recency & limit. Gonna be tricky bridging this fucking gap. Will need node queue.
    user.subscriptions.map do |s|
      s.post.serializable_hash.merge({"last" => s.post.top_message})
    end
  end
end
