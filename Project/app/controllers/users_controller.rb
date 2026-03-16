class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end
  def create
    user = CreateUser.call(user_params)
    render json: user, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
