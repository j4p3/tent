class Users::UsersController < ApplicationController
    def index
      # Return all users
      if params[:ids]
        @users = User.find(params[:ids]).eager_load(:posts)
      elsif params
        @users = User.where(params.except(:format, :action, :controller))
        status = :not_found if @users.empty?
      else
        @users = User.all
      end
      render json: @users, status: status
    end

  def show
    @user = User.find(params[:id])
    render json: @user
  end
end