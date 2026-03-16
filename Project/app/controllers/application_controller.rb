class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)

    case resource
    when Admin
      admin_dashboard_path

    when User
      dashboard_path

    when Hospital
      hospital_dashboard_path

    when BloodBank
      blood_bank_dashboard_path

    else
      super
    end

  end
end
