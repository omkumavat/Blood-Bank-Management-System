class User::DashboardController < ApplicationController

  # before_action :authenticate_user!
  layout "user_dashboard"

  def index
    Rails.logger.debug "TEST SESSION: #{session[:test]}"
  Rails.logger.debug "WARDEN USER: #{warden.user(:user).inspect}"
  end

end
