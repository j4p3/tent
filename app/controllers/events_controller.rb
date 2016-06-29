class EventsController < ApplicationController
  def index
    # @todo create new_for so that these events can be sent and dismissed
    @user = User.find(params[:user_id])

    @interactions = Interaction.for(@user).limit(10)
    @posts = Post.for(@user).limit(10)
    @messages = Post.subbed(@user)

    # @todo date-sort and paginate this list
    # @todo post from queue so this doesn't rely on n network requests : (

    @events = []
    @events.concat(@interactions.map { |i| Event.new(i) })
    @events.concat(@messages.map { |i| Event.new(i.request_last_message) })
    @events.concat(@posts.map { |i| Event.new(i) })

    render json: @events
  end
end
