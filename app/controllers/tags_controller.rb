class TagsController < ApplicationController
  def index
    # Return all tags (usually called with params)
    if params[:ids]
      @tags = Tag.find(params[:ids])
    elsif params
      @tags = Tag.where(params.except(:format, :action, :action, :controller))
      status = :not_found if @tags.empty?
    else
      @tags = Tag.all
    end
    render 'tags/index', status: status
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
