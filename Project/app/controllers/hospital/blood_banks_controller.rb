class Hospital::BloodBanksController < ApplicationController
  before_action :authenticate_hospital!
  layout "hospital_dashboard"

  def index
    @hospital_blood_bank = BloodBank.find_by(hospital_id: current_hospital.id)
    if @hospital_blood_bank.present?
      @hospital_blood_stocks = BloodStock.where(blood_bank_id: @hospital_blood_bank.id)
    end
  end
end