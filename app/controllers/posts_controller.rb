class PostsController < ApplicationController
  def index
    # Return 'active' (non-resolved posts) and their tags to index view
    @posts = Post.includes([:tent, :user]).active.order(created_at: :desc)
    if params[:tent_id] && tent = Tent.find(params[:tent_id])
      # @todo concat descendant posts with own posts
     @posts = tent.posts.order(created_at: :desc)
    end
    render json: @posts
  end

  def show
    # Return given post and its tags to show view. Expects params hash with id k/v.
    @post = Post.find_by_id(params[:id])
    render json: @post
  end

  def create
    if user = User.find(post_params[:user_id])
      @post = user.posts.new(post_params)

      if @post.save
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      status :not_found
    end
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  rescue Exception => e
    raise e
  end

  def delete
    @post = Post.find_by_id(params[:id])
    @post.destroy

    head :no_content
  end
end

private

  def post_params
    params.require(:post).permit(:headline, :content, :resolved, :tent_id, :user_id)
  end
