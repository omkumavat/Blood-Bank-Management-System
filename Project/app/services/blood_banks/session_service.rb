# app/services/users/session_service.rb
require "ostruct"

module BloodBanks
  class SessionService
    def initialize(params)
      @params = params
    end

    def call
      user = BloodBank.find_by(email: @params[:email])

      if user&.valid_password?(@params[:password])
        OpenStruct.new(success?: true, user: user)
      else
        OpenStruct.new(success?: false, error: "Invalid email or password")
      end
    end
  end
end