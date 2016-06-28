class SubscriptionsController < ApplicationController
  def index
    @subscriptions = User.find(params[:user_id]).subscriptions.includes(:post)
    render json: @subscriptions
  end

  def create
    if user = User.find(params[:user_id])
      
      @subscriptions = user.subscriptions.find_or_initialize_by(
        post_id: params[:post_id]
      )

      if @subscriptions.save
        render json: @subscriptions
      else
        render json: @subscriptions.errors, status: :unprocessable_entity
      end
    else
      status :not_found
    end
  end

  def destroy
  end
end

private

  def subscription_params
    require(:subscription).permit(:user_id, :post_id)
  end