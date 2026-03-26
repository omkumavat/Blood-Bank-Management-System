class BloodBank::DashboardController < ApplicationController
  before_action :authenticate_blood_bank!
  layout "blood_bank_dashboard"

  def index
  end

end 