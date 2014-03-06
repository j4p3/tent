class PostsController < ApplicationController
  def index
    # Return 'active' (non-resolved posts) and their tags to index view
    @posts = Post.active.eager_load(:tags)
    render json: @posts
    # render 'posts/index'
  end

  def show
    # Return given post and its tags to show view. Expects params hash with id k/v.
    @post = Post.includes(:tags).find_by_id(params[:id])
    render json: @post
    # render 'posts/show'
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      render 'posts/show'
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.update(params[:post])
      render 'posts/show'
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def delete
    @post = Post.find_by_id(params[:id])
    @post.destroy

    head :no_content
  end
end
