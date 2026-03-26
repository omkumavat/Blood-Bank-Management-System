class AdminMailer < ApplicationMailer
    def welcome_email_blood_bank
    @blood_bank = params[:blood_bank]
    @url  = "http://localhost:3000/blood_bank/login"
    mail(to: @blood_bank.email, subject: "Welcome to Blood Bank Site")
  end

  def welcome_email_hospital
    @hospital = params[:hospital]
    @url  = "http://localhost:3000/hospital/login"
    mail(to: @hospital.email, subject: "Welcome to Blood Bank Site")
  end
    
end
