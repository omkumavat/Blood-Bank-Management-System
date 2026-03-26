class User::DonationAppointmentsController < ApplicationController

  before_action :authenticate_user!
  layout "user_dashboard"

  def index
    @sort = params[:sort]

    appointments = DonationAppointment
                    .where(user_id: current_user.id)
                    .includes(:blood_bank)

    case @sort
    when "oldest"
      @donation_appointments = appointments.order(scheduled_date: :asc)

    when "upcoming"
      @donation_appointments = appointments.where("scheduled_date >= ?", Date.today)
                                            .order(scheduled_date: :asc)

    when "past"
      @donation_appointments = appointments.where("scheduled_date < ?", Date.today)
                                            .order(scheduled_date: :desc)

    else
      @donation_appointments = appointments.order(created_at: :desc)
    end


  end

 
  def new 
    @blood_bank = BloodBank.find(params[:blood_bank_id])
  end

  def create
    @blood_bank = BloodBank.find(params[:blood_bank_id])

    slot = params[:time_slot]

    if slot == "slot1"
      start_time = "09:00"
      end_time = "10:00"

    elsif slot == "slot2"
      start_time = "11:00"
      end_time = "12:00"

    elsif slot == "slot3"
      start_time = "14:00"
      end_time = "15:00"
    end
  
    @donation_appointment = DonationAppointment.new(
      user_id: current_user.id,
      blood_bank_id: @blood_bank.id,
      status: "scheduled",
      scheduled_date: params[:scheduled_date],
      scheduled_time_start: start_time,
      scheduled_time_end: end_time
    )

    if @donation_appointment.save
      redirect_to user_dashboard_path, notice: "Donation appointment sent successfully."
    else
      render :show_blood_bank
    end
  end
end
