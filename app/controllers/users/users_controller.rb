class Users::UsersController < ApplicationController
    def index
      # Return all users
      if user_params[:ids]
        @users = User.find(user_params[:ids]).eager_load(:posts)
      elsif user_params
        @users = User.where(user_params.except(:format, :action, :controller))
        status = :not_found if @users.empty?
      else
        @users = User.all
      end
      render json: @users, status: status
    end

  def show
    @user = User.find(user_params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    if @user = User.find_by(email: user_params[:email])
      if @user.authenticate(user_params[:password])
        render json: @user
      else
        render json: {error: "Sorry, that's not the password we have saved for #{user_params[:email] || 'that user'}. Try again or create a new account."}, status: :unauthorized
      end
    else
      render json: {error: "Sorry, we don't recognize #{user_params[:email] || 'that user'}. Try again or create a new account."}, status: :not_found
    end
  end
end

private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :avatar)
  end
