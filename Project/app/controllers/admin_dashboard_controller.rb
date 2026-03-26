class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_dashboard"

  def dashboard
  end

   def index
  end

  def blood_banks
    status = params[:status]
    
    if status == "verified"
      @blood_banks = BloodBank.where(verified: true)
    elsif status == "pending"
      @blood_banks = BloodBank.where(verified: false)
    else 
      @blood_banks = BloodBank.all
    end
  end

  def verify_admin_blood_bank
    blood_bank = BloodBank.find(params[:id])
    blood_bank.update(verified: true)

    if blood_bank.verified == true
      AdminMailer.with(blood_bank: blood_bank).welcome_email_blood_bank.deliver_later
    end
    redirect_to manage_blood_banks_path, notice: "Blood bank verified successfully."
  end

  def hospitals
    status = params[:status]
    
    if status == "verified"
      @hospitals = Hospital.where(verified: true)
    elsif status == "pending"
      @hospitals = Hospital.where(verified: false)
    else 
      @hospitals = Hospital.all
    end
  end

   def verify_admin_hospital
    hospital = Hospital.find(params[:id])
    hospital.update(verified: true)

    if hospital.verified == true
      AdminMailer.with(hospital: hospital).welcome_email_hospital.deliver_later
    end

    redirect_to manage_hospitals_path, notice: "Hospital verified successfully."
  end

end