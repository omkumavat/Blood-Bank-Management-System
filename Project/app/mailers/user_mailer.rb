class UserMailer < ApplicationMailer
    def notify_blood_request
    @user = params[:user]
    @blood_request = params[:blood_request]
    @hospital = params[:hospital]
    @url="https://blood-bank-management-system-pphz.onrender.com/user/dashboard"
    mail(to: @user.email, subject: "New Blood Request from #{@hospital.name}")
  end
    
end
