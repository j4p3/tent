class InteractionsController < ApplicationController
def index
    @interactions = Interaction.includes([:post, :tent, :user, :interaction_type]).where(target_user: params[:user_id]).order(:created_at).order('posts.created_at DESC')
    render json: @interactions
  end

  def show
    @interaction = Interaction.find(params[:id])
    render json: @interaction
  end

  def create
    if user = User.find(interaction_params[:origin_user_id])
      target_user_id = Post.find(interaction_params[:post_id]).user_id
      
      # @todo variable interaction_type from client
      # @todo figure out why interactions are duplicating
      @interaction = user.interactions.find_or_initialize_by(
        interaction_type_id: 3,
        post_id: interaction_params[:post_id],
        target_user_id: target_user_id
      )

      if @interaction.save
        render json: @interaction
      else
        render json: @interaction.errors, status: :unprocessable_entity
      end
    else
      status :not_found
    end
  end

  def update
    @interaction = Interaction.find_by_id(params[:id])

    if @interaction.update(interaction_params)
      render json: @interaction
    else
      render json: @interaction.errors, status: :unprocessable_entity
    end
  rescue Exception => e
    raise e
  end

  def delete
    @interaction = Interaction.find_by_id(params[:id])
    @interaction.destroy

    head :no_content
  end
end

private

  def interaction_params
    params.require(:interaction).permit(:interaction_type_id, :tent_id, :origin_user_id, :target_user_id, :post_id)
  end