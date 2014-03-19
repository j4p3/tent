class TagsController < ApplicationController
  def index
    # Return all tags (usually called with params)
    if params[:ids]
      @tags = Tag.find(params[:ids]).eager_load(:posts)
    elsif params
      @tags = Tag.where(params.except(:format, :action, :action, :controller)).eager_load(:posts)
      status = :not_found if @tags.empty?
    else
      @tags = Tag.eager_load(:posts)
    end
    render json: @tags, status: status
  end

  def show
  end

  def create
  end

  def update
  end

  def delete
  end
end
