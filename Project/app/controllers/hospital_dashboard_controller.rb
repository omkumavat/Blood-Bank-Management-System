class HospitalDashboardController < ApplicationController
  before_action :authenticate_hospital!
  layout "hospital_dashboard"

  def index
  end

  def dashboard
  end

  def hospital_blood_bank
    @hospital_blood_bank = BloodBank.find_by(hospital_id: current_hospital.id)
    if @hospital_blood_bank.present?
      @hospital_blood_stocks = BloodStock.where(blood_bank_id: @hospital_blood_bank.id)
    end
  end

  def update_blood_stock
    blood_stock = BloodStock.find_by(id: params[:update_blood_stock][:blood_stock_id], blood_bank_id: params[:update_blood_stock][:blood_bank_id])
    
    if blood_stock.nil?
      redirect_to manage_hospital_blood_bank_path,
      alert: "Blood stock not found."
      return
    end

    if blood_stock.update(quantity: params[:quantity])
      redirect_to manage_hospital_blood_bank_path,
      notice: "Blood stock updated successfully."
    else
      redirect_to manage_hospital_blood_bank_path,
      alert: "Failed to update blood stock."
    end
  end


  def create_blood_stock
    
    if blood_stock_params[:blood_bank_id].nil?
      redirect_to manage_hospital_blood_bank_path,
      alert: "No blood bank associated with this hospital."
      return
    end

    blood_stock_of_same_group = BloodStock.find_by(
      blood_bank_id: blood_stock_params[:blood_bank_id],
      blood_group: blood_stock_params[:blood_group]
    )

    if blood_stock_of_same_group.present?
      redirect_to manage_hospital_blood_bank_path,
      alert: "Blood stock of this group already exists. You can update the quantity instead."
      return
    end

    blood_stock = BloodStock.new(blood_stock_params)

    if blood_stock.save
      redirect_to manage_hospital_blood_bank_path,
      notice: "Blood stock added successfully."
    else
      redirect_to manage_hospital_blood_bank_path,
      alert: "Failed to add blood stock."
    end
  end


  def blood_requests

    status = params[:status]
    
    if status == "pending"
      @blood_requests = BloodRequest.where(hospital_id: current_hospital.id, status: "pending").includes(:blood_bank, :hospital, :user)
    elsif status == "fulfilled"
      @blood_requests = BloodRequest.where(hospital_id: current_hospital.id, status: "fulfilled").includes(:blood_bank, :hospital, :user)
    else 
      @blood_requests = BloodRequest.where(hospital_id: current_hospital.id).includes(:blood_bank, :hospital, :user)
    end

  end

  def blood_requests_form
  end

def create_blood_request

  status = "pending"
  blood_bank_id = nil

  allowed_to_users = params[:blood_request][:allowed_to_users]

  blood_bank_own = BloodBank.find_by(hospital_id: current_hospital.id)

  if blood_bank_own.present?

    blood_stock_own = BloodStock.find_by(
      blood_group: blood_request_params[:blood_group],
      blood_bank_id: blood_bank_own.id
    )

    if blood_stock_own.present? &&
       blood_stock_own.quantity >= blood_request_params[:quantity].to_i

      status = "fulfilled"
      blood_bank_id = blood_bank_own.id

      blood_stock_own.update(
        quantity: blood_stock_own.quantity - blood_request_params[:quantity].to_i
      )
    end
  end


  if status == "pending"

    blood_stocks = BloodStock
      .where(blood_group: blood_request_params[:blood_group])
      .where("quantity >= ?", blood_request_params[:quantity].to_i)
      .includes(:blood_bank)

    if blood_stocks.present?

      blood_stocks.each do |blood_stock|

        if blood_stock.blood_bank&.city == current_hospital.city && 
           blood_stock.blood_bank&.state == current_hospital.state &&
           blood_stock.blood_bank&.country == current_hospital.country

          status = "fulfilled"
          blood_bank_id = blood_stock.blood_bank_id

          blood_stock.update(
            quantity: blood_stock.quantity - blood_request_params[:quantity].to_i
          )

          break
        end
      end
    end
  end


  if status == "fulfilled"

    BloodRequest.create!(
      blood_request_params.merge(
        hospital_id: current_hospital.id,
        blood_bank_id: blood_bank_id,
        status: status,
        allowed_to_users: allowed_to_users == "true" ? true : false
      )
    )

  else

    if allowed_to_users == "true"

      BloodRequest.create!(
        blood_request_params.merge(
          hospital_id: current_hospital.id,
          blood_bank_id: nil,
          status: status,
          allowed_to_users: allowed_to_users == "true" ? true : false
        )
      )

      users = User.where(
        city: current_hospital.city,
        state: current_hospital.state,
        country: current_hospital.country,
        blood_group: blood_request_params[:blood_group]
      )

      users.each do |user|
        UserMailer.with(user: user, blood_request: BloodRequest.last, hospital: current_hospital).notify_blood_request.deliver_later
      end 

    else

      BloodRequest.create!(
        blood_request_params.merge(
          hospital_id: current_hospital.id,
          blood_bank_id: nil,
          status: status,
          allowed_to_users: allowed_to_users == "true" ? true : false
        )
      )

      redirect_to hospital_blood_requests_path,
      alert: "No blood bank has sufficient stock."
      return
    end

  end

  redirect_to hospital_blood_requests_path,
  notice: "Blood request created successfully."

end

  private
  def blood_request_params
  params.require(:blood_request).permit(
    :blood_group,
    :quantity,
  )
  end

  def blood_stock_params
  params.require(:blood_stock).permit(
    :blood_group,
    :quantity,
    :blood_bank_id
  )
end
end