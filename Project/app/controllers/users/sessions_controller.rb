# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /users/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    render :new
  end

  # POST /users/sign_in
  def create
    result = Users::SessionService.new(sign_in_params).call

    if result.success?
      sign_in(resource_name, result.user)
      redirect_to user_dashboard_path, notice: "Signed in successfully."
    else
      flash.now[:alert] = result.error
      self.resource = resource_class.new
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /users/sign_out
  def destroy
    Users::LogoutService.new(current_user).call if current_user.present?
    sign_out(current_user)
    redirect_to new_user_session_path, notice: "Signed out successfully."
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end