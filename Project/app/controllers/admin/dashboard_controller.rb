class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_dashboard"

  def index
  end

end