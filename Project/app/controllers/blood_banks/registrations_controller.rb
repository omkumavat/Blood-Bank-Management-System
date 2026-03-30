class BloodBanks::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create

    if current_hospital.present?
      service = BloodBanks::RegistrationService.new(
      sign_up_params,
      current_hospital
    )
    else
      service = BloodBanks::RegistrationService.new(
        sign_up_params,
        nil
      )
    end

    result = service.call

    if result.success?
      if current_hospital.present?
        redirect_to manage_hospital_blood_bank,
        notice: "Blood bank registered successfully. Waiting for verification."
      else
        redirect_to new_blood_bank_session_path,
        notice: "Blood bank registered successfully."
      end
    else
      flash.now[:alert] = result.error
      build_resource
      render :new
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :name, :country, :state, :city,
      :address, :pincode, :phone_number
    ])
  end
end