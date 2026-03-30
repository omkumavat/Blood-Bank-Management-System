# app/services/users/logout_service.rb
require "ostruct"

module Users
  class LogoutService
    def initialize(user)
      @user = user
    end

    def call
      # Add custom logout logic here if needed
      # Example:
      # @user.update(last_logout_at: Time.current)

      OpenStruct.new(success?: true)
    end
  end
end