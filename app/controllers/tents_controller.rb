class TentsController < ApplicationController
  def index
    @tents = Tent.first.and_descendants_tree
    render json: @tents
  end

  def show
    @tent = Tent.find_by_id(params[:id])
    render json: @tent
  end

  def create
    @tent = current_user.tents.new(tent_params)

    if @tent.save
      render json: @tent
    else
      render json: @tent.errors, status: :unprocessable_entity
    end
  end

  def update
    @tent = Tent.find_by_id(params[:id])

    if @tent.update(tent_params)
      render json: @tent
    else
      render json: @tent.errors, status: :unprocessable_entity
    end
  rescue Exception => e
    raise e
  end

  def delete
    @tent = Tent.find_by_id(params[:id])
    @tent.destroy

    head :no_content
  end
end

private

  def tent_params
    params.require(:tent).permit(:name, :desc, :image, :parent_id)
  end