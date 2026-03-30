# app/controllers/users/profiles_controller.rb
class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def complete
    @user = current_user
  end

  def update_profile
    @user = current_user

    update_params = profile_params
    if update_params[:password].blank?
      update_params = update_params.except(:password_confirmation)
    end

    if @user.update(update_params)
      bypass_sign_in(@user)
      redirect_to user_dashboard_path, notice: "Profile completed successfully!"
    else
      render :complete, status: :unprocessable_entity
    end
  end

  private

def profile_params
  params.require(:user).permit(
    :phone_number, :country, :state, :city,
    :address, :pincode, :date_of_birth, :blood_group,
    :password, :password_confirmation
  )
end
end