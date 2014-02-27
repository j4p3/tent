class TagsController < ApplicationController
  def index
    # Return all tags (usually called with params[ids])
    if params[:ids]
      @tags = Tag.find(params[:ids])
    else
      @tags = Tag.all
    end
    render 'tags/index'
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
