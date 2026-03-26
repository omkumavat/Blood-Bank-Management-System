class AdminMailer < ApplicationMailer
    def welcome_email_blood_bank
    @blood_bank = params[:blood_bank]
    @url  = "https://blood-bank-management-system-pphz.onrender.com/blood_bank/login"
    mail(to: @blood_bank.email, subject: "Welcome to Blood Bank Site")
  end

  def welcome_email_hospital
    @hospital = params[:hospital]
    @url  = "https://blood-bank-management-system-pphz.onrender.com/hospital/login"
    mail(to: @hospital.email, subject: "Welcome to Blood Bank Site")
  end
    
end
