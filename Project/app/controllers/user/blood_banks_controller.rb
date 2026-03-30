class User::BloodBanksController < ApplicationController

  before_action :authenticate_user!
  layout "user_dashboard"
 
  def index
    @city = current_user.city

    if @city.present?
      @blood_banks = BloodBank.where(city: @city).where(verified: true)
    else
      @blood_banks = BloodBank.all
    end
  end


  def show
    @blood_bank = BloodBank.find(params[:id])
  end
end
