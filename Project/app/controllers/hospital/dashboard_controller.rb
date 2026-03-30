class Hospital::DashboardController < ApplicationController
  before_action :authenticate_hospital!
  layout "hospital_dashboard"

  def index
  end

end