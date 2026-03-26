class User::BloodRequestsController < ApplicationController

  before_action :authenticate_user!
  layout "user_dashboard"

  def index
  @blood_requests = BloodRequest.where(status: "pending", allowed_to_users: true, blood_group: current_user.blood_group).includes(:hospital)

    @blood_requests = @blood_requests.joins(:hospital)
        .where("hospitals.city ILIKE ?  OR hospitals.state ILIKE ? OR hospitals.country ILIKE ?",
          "%#{current_user.city}%",
          "%#{current_user.state}%",
          "%#{current_user.country}%"
        )
  end

  def accept
    blood_request = BloodRequest.find(params[:id])
    blood_request.update(status: "fulfilled", user_id: current_user.id)

    redirect_to user_dashboard_path, notice: "Blood request accepted successfully."
  end

  def show 
    @blood_request = BloodRequest.find(params[:id])
  end

  def accepted
    @blood_requests = BloodRequest.where(status: "fulfilled", user_id: current_user.id
    ).includes(:hospital)
  end
end
