class Admin::BloodBanksController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_dashboard"

  def index
    status = params[:status]
    
    if status == "verified"
      @blood_banks = BloodBank.where(verified: true)
    elsif status == "pending"
      @blood_banks = BloodBank.where(verified: false)
    else 
      @blood_banks = BloodBank.all
    end
  end

  def verify
    blood_bank = BloodBank.find(params[:id])
    blood_bank.update(verified: true)

    if blood_bank.verified == true
      AdminMailer.with(blood_bank: blood_bank).welcome_email_blood_bank.deliver_later
    end
    redirect_to manage_blood_banks_path, notice: "Blood bank verified successfully."
  end

end