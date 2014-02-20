class PostsController < ApplicationController
  def index
    @posts = Post.all
    render 'posts/index'
  end

  def show
    @post = Post.find_by_id(params[:id])
    render 'posts/show'
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
