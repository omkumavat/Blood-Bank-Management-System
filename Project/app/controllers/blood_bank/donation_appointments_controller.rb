class BloodBank::DonationAppointmentsController < ApplicationController
  before_action :authenticate_blood_bank!
  layout "blood_bank_dashboard"

  def index
    @donation_appointments = DonationAppointment.includes(:user, :blood_bank)

    if params[:search].present?
    @donation_appointments = @donation_appointments.joins(:user)
      .where("users.first_name ILIKE ? OR users.email ILIKE ? OR users.phone_number ILIKE ?", 
             "%#{params[:search]}%", 
             "%#{params[:search]}%", 
             "%#{params[:search]}%")
    end

    if params[:status].present?
      @donation_appointments = @donation_appointments.where(status: params[:status])
    end
  end


  def accept
    appointment = DonationAppointment.find_by(id: params[:id], blood_bank_id: params[:blood_bank_id])
    appointment.update(status: "completed")

    blood_stock = BloodStock.find_or_initialize_by(blood_bank_id: params[:blood_bank_id], blood_group: params[:blood_group], 
    quantity: 0)
    blood_stock.quantity += 1
    blood_stock.save

    redirect_to blood_bank_donation_appointments_path, notice: "Donation request accepted successfully."
  end


end 