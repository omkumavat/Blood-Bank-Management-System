class BloodBank::BloodStocksController < ApplicationController
  before_action :authenticate_blood_bank!
  layout "blood_bank_dashboard"

  def index
    @blood_stocks = BloodStock.where(blood_bank_id: current_blood_bank.id)
  end

  def edit
    # @hospital_blood_bank = current_hospital
    @blood_stock = BloodStock.find(params[:id])
  end

  def update

    if current_blood_bank.id.nil?
      redirect_to blood_bank_blood_stocks_path,
      alert: "No blood bank associated with this hospital."
      return
    end

    blood_stock = BloodStock.find_by(id: params[:id], blood_bank_id: current_blood_bank.id)
    
    if blood_stock.nil?
      redirect_to blood_bank_blood_stocks_path,
      alert: "Blood stock not found."
      return
    end

    if blood_stock.update(quantity: blood_stock_params[:quantity])
      redirect_to blood_bank_blood_stocks_path,
      notice: "Blood stock updated successfully."
    else
      redirect_to edit_blood_bank_blood_stock_path,
      alert: "Failed to update blood stock."
    end
  end

  def new 
    # @hospital_blood_bank = current_hospital.blood_bank
  end

  def create
    
    if current_blood_bank.id.nil?
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

    blood_stock = BloodStock.new(blood_group: blood_stock_params[:blood_group], 
                                 quantity: blood_stock_params[:quantity],
                                 blood_bank_id: current_blood_bank.id)

    if blood_stock.save
      redirect_to blood_bank_blood_stocks_path,
      notice: "Blood stock added successfully."
    else
      redirect_to new_blood_bank_blood_stock_path,
      alert: "Failed to add blood stock."
    end
  end

  private

  def blood_stock_params
    params.require(:blood_stock).permit(
      :blood_group,
      :quantity,

      # :blood_bank_id
    )
  end

end 