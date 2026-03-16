require "ostruct"

module Users
  class RegistrationService
    attr_reader :user, :errors

    def initialize(params)
      @params = params
    end

    def call
      @user = User.new(@params)

      if @user.save
        success_response
      else
        failure_response
      end
    end

    private

    def success_response
      OpenStruct.new(success?: true, user: @user)
    end

    def failure_response
      OpenStruct.new(success?: false, errors: @user.errors.full_messages)
    end
  end
end