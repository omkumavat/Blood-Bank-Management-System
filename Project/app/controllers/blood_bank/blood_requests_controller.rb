class BloodBank::BloodRequestsController < ApplicationController
  before_action :authenticate_blood_bank!
  layout "blood_bank_dashboard"

  def index
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

  def show 
    @blood_request = BloodRequest.includes(:hospital, :blood_bank).find_by(id: params[:id])
  end
end 