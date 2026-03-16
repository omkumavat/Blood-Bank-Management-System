class BloodBankDashboardController < ApplicationController
  before_action :authenticate_blood_bank!
  layout "blood_bank_dashboard"

  def index
  end

  def dashboard
    # You can add any logic here to fetch data for the dashboard
  end

  def donation_requests
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


  def accept_donation_appointment
    appointment = DonationAppointment.find_by(id: params[:appointment_id], blood_bank_id: params[:blood_bank_id])
    appointment.update(status: "completed")

    blood_stock = BloodStock.find_or_initialize_by(blood_bank_id: params[:blood_bank_id], blood_group: params[:blood_group], 
    quantity: 0)
    blood_stock.quantity += 1
    blood_stock.save

    redirect_to blood_bank_donation_requests_path, notice: "Donation request accepted successfully."
  end

  def blood_requests
    @blood_requests = BloodRequest.where(blood_bank_id: current_blood_bank.id).includes(:hospital, :blood_bank)
    if params[:search].present?
      @blood_requests = @blood_requests.joins(:hospital)
        .where("hospitals.name ILIKE ? ",
          "%#{params[:search]}%",
        )
    end

    if params[:blood_group].present?
      @blood_requests = @blood_requests.where(blood_group: params[:blood_group])
    end

    if params[:quantity].present?
      @blood_requests = @blood_requests.where("quantity > ?", params[:quantity])
    end
  end

    def blood_stocks
      @blood_stocks = BloodStock.where(blood_bank_id: current_blood_bank.id)
    end

    def update_blood_stock
    blood_stock = BloodStock.find_by(id: params[:update_blood_stock][:blood_stock_id], blood_bank_id: current_blood_bank.id)
    
    if blood_stock.nil?
      redirect_to blood_bank_blood_stocks_path,
      alert: "Blood stock not found."
      return
    end

    if blood_stock.update(quantity: params[:quantity])
      redirect_to blood_bank_blood_stocks_path,
      notice: "Blood stock updated successfully."
    else
      redirect_to blood_bank_blood_stocks_path,
      alert: "Failed to update blood stock."
    end
  end


  def create_blood_stock
    
    if current_blood_bank.nil?
      redirect_to blood_bank_blood_stocks_path,
      alert: "No blood bank associated with this hospital."
      return
    end

    blood_stock_of_same_group = BloodStock.find_by(
      blood_bank_id: current_blood_bank.id,
      blood_group: blood_stock_params[:blood_group]
    )

    if blood_stock_of_same_group.present?
      redirect_to blood_bank_blood_stocks_path,
      alert: "Blood stock of this group already exists. You can update the quantity instead."
      return
    end

    blood_stock = BloodStock.new(blood_stock_params)

    # redirect_to blood_bank_blood_stocks_path,
    # alert: "#{blood_stock.blood_group} #{blood_stock.quantity} #{blood_stock.blood_bank_id}."

    if blood_stock.save
      redirect_to blood_bank_blood_stocks_path,
      notice: "Blood stock added successfully."
    else
      redirect_to blood_bank_blood_stocks_path,
      alert: "Failed to add blood stock. #{blood_stock.blood_group}"
    end
  end

  def blood_stock_params
  params.require(:blood_stock).permit(
    :blood_group,
    :quantity,
    :blood_bank_id
  )
  end

end 