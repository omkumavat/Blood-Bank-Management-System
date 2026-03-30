# frozen_string_literal: true

class Hospitals::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  before_action :configure_sign_in_params, only: [:create]

  # GET /users/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    render :new
  end


  # POST /resource/sign_in
 def create
    hp=Hospital.find_by(email: sign_in_params[:email])
    if hp && !hp.verified
      flash.now[:alert] = "Your account is pending verification. Please wait for admin approval."
      self.resource = resource_class.new
      render :new, status: :unprocessable_entity
      return  
    end
    result = Hospitals::SessionService.new(sign_in_params).call

    if result.success?
      sign_in(resource_name, result.user)
      redirect_to hospital_dashboard_path, notice: "Signed in successfully."
    else
      flash.now[:alert] = result.error
      self.resource = resource_class.new
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
