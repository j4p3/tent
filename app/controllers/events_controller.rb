class EventsController < ApplicationController
  def index
    # @todo create new_for so that these events can be sent and dismissed
    @user = User.find(params[:user_id])

    @interactions = Interaction.for(@user).limit(10)
    @posts = Post.for(@user).limit(10)
    @messages = Subscription.new_for(@user)

    render json: {
      interactions: serialize(@interactions),
      messages: serialize(@messages),
      posts: serialize(@posts)
    }
  end

  private

  def serialize(list)
    list.map do |i|
      ActiveModelSerializers::SerializableResource.new(i).as_json
    end
  end
end
