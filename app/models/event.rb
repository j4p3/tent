class Event
  # 
  # An action performed by someone other than the current user.
  # Should give context on:
  #   action type e.g. interaction, message, post
  #   post this action occurred on(?) (could have e.g. private message events)
  #   user behind the action
  # 

  include ActiveModel::Serialization
  attr_reader :type, :user, :post

  def initialize(attributes)
    # User ActiveRecord object
    @user = attributes[:user]

    # Post ActiveRecord object
    @post = attributes[:post]

    # Symbol (:interaction, :post, :stream)
    @type = attributes[:type]
  end

  def self.new_for(user)
    Interaction.new_for(user.id)
    Post.new_for(user.id)
  end
end