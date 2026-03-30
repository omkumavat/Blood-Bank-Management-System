class ApplicationController < ActionController::Base
    before_action :set_current_user
    before_action :get_set_theme
    
  def after_sign_in_path_for(resource)

    case resource
    when Admin
      admin_dashboard_path

    when User
      user_dashboard_path

    when Hospital
      hospital_dashboard_path

    when BloodBank
      blood_bank_dashboard_path

    else
      super
    end

  end

  private

  def set_current_user
    @current_user = current_user
  end

  def get_set_theme
    @theme = cookies[:theme] || "light"
  end
end
