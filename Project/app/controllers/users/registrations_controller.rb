# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /users/sign_up
  def new
    super
  end

  # POST /users
  def create
    result = Users::RegistrationService.new(sign_up_params).call

    if result.success?
      sign_up(resource_name, result.user)
      render json: { message: "User registered successfully", user: result.user }, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  # GET /users/edit
  def edit
    render json: { user: current_user }
  end

  # PUT /users
  def update
    result = Users::UpdateService.new(current_user, account_update_params).call

    if result.success?
      render json: { message: "Account updated successfully", user: result.user }
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /users
  def destroy
    result = Users::DeleteService.new(current_user).call

    if result.success?
      sign_out(current_user)
      render json: { message: "Account deleted successfully" }
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  # GET /users/cancel
  def cancel
    super
  end

  protected

  def configure_sign_up_params
  devise_parameter_sanitizer.permit(:sign_up, keys: [
    :first_name, :last_name, :phone_number,
    :country, :state, :city, :address,
    :pincode, :date_of_birth, :blood_group
  ])
end 

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
    :first_name, :last_name, :phone_number,
    :country, :state, :city, :address,
    :pincode, :date_of_birth, :blood_group
  ])
  end
end