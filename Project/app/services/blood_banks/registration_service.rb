require "ostruct"

module BloodBanks
    class RegistrationService
      def initialize(params, hospital=nil)
        @hospital = hospital
        @params = params
      end

      def call

        blood_bank = BloodBank.new(@params)
        if @hospital.present?
          blood_bank.hospital_id = @hospital.id
          blood_bank.verified = true
        end

        if blood_bank.save
          success(blood_bank)
        else
          failure(blood_bank.errors.full_messages.join(", "))
        end
      end

      private

      def success(blood_bank)
        OpenStruct.new(success?: true, blood_bank: blood_bank)
      end

      def failure(message)
        OpenStruct.new(success?: false, error: message)
      end
  end
end