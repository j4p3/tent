class PostsController < ApplicationController
  def index
    # Return 'active' (non-resolved posts) and their tags to index view
    @posts = Post.active.eager_load(:tags)
    render json: @posts
  end

  def show
    # Return given post and its tags to show view. Expects params hash with id k/v.
    @post = Post.includes(:tags).find_by_id(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(params[:post].except :tags, :updated_at)

    if @post.save
      if params[:post][:tags].respond_to? :each
        params[:post][:tags].each do |tag_attributes|
          @post.tags << Tag.where(tag_attributes).first_or_create
        end
      end
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.update(params[:post].except :tags, :updated_at)
      if params[:post].has_key? :tags
        @post.tags.clear
        if params[:post][:tags].respond_to? :each
          params[:post][:tags].each do |tag_attributes|
            @post.tags << Tag.where(tag_attributes).first_or_create
          end
        end
      end
      render json: @post
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
