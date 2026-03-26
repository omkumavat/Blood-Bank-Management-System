class Hospital::BloodStocksController < ApplicationController
  before_action :authenticate_hospital!
  layout "hospital_dashboard"

  def edit
    @hospital_blood_bank = current_hospital.blood_bank
    @blood_stock = BloodStock.find(params[:id])
  end

  def update

    if blood_stock_params[:blood_bank_id].nil?
      redirect_to hospital_blood_banks_path,
      alert: "No blood bank associated with this hospital."
      return
    end

    blood_stock = BloodStock.find_by(id: params[:id], blood_bank_id: blood_stock_params[:blood_bank_id])\
    
    if blood_stock.nil?
      redirect_to hospital_blood_banks_path,
      alert: "Blood stock not found."
      return
    end

    if blood_stock.update(quantity: blood_stock_params[:quantity])
      redirect_to hospital_blood_banks_path,
      notice: "Blood stock updated successfully."
    else
      redirect_to edit_hospital_blood_bank_blood_stock_path,
      alert: "Failed to update blood stock."
    end
  end

  def new 
    @hospital_blood_bank = current_hospital.blood_bank
  end

  def create
    
    if blood_stock_params[:blood_bank_id].nil?
      redirect_to hospital_blood_banks_path,
      alert: "No blood bank associated with this hospital."
      return
    end

    blood_stock_of_same_group = BloodStock.find_by(
      blood_bank_id: blood_stock_params[:blood_bank_id],
      blood_group: blood_stock_params[:blood_group]
    )

    if blood_stock_of_same_group.present?
      redirect_to hospital_blood_banks_path,
      alert: "Blood stock of this group already exists. You can update the quantity instead."
      return
    end

    blood_stock = BloodStock.new(blood_stock_params)

    if blood_stock.save
      redirect_to hospital_blood_banks_path,
      notice: "Blood stock added successfully."
    else
      redirect_to new_hospital_blood_bank_blood_stocks_path,
      alert: "Failed to add blood stock."
    end
  end

  private

  def blood_stock_params
    params.require(:blood_stock).permit(
      :blood_group,
      :quantity,
      :blood_bank_id
    )
  end
end