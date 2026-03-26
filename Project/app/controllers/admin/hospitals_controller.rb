class Admin::HospitalsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_dashboard"

  def index
    status = params[:status]
    
    if status == "verified"
      @hospitals = Hospital.where(verified: true)
    elsif status == "pending"
      @hospitals = Hospital.where(verified: false)
    else 
      @hospitals = Hospital.all
    end
  end

   def verify
    hospital = Hospital.find(params[:id])
    hospital.update(verified: true)

    if hospital.verified == true
      AdminMailer.with(hospital: hospital).welcome_email_hospital.deliver_later
    end

    redirect_to manage_hospitals_path, notice: "Hospital verified successfully."
  end

end