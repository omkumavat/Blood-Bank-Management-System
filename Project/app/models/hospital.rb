class Hospital < ApplicationRecord
  has_one :blood_bank
  has_many :blood_requests



  

  
validates :name, :country, :state, :city, :address,
          :phone_number, :pincode,
          presence: { message: "cannot be blank" }


validates :name,
          length: {
            minimum: 2,
            maximum: 100,
            message: "must be between 2 and 100 characters"
          }


validates :address,
          length: {
            minimum: 5,
            maximum: 255,
            message: "must be between 5 and 255 characters"
          }


validates :phone_number,
           uniqueness: true,
          numericality: {
            only_integer: true,
            message: "must contain only digits"
          },
          length: {
            is: 10,
            message: "must be exactly 10 digits"
          }


validates :pincode,
          numericality: {
            only_integer: true,
            message: "must contain only digits"
          },
          length: {
            is: 6,
            message: "must be exactly 6 digits"
          }

validates :website,
          format: {
            with: URI::DEFAULT_PARSER.make_regexp(%w[https]),
            message: "must be a valid HTTPS URL (starting with https://)"
          },
          allow_blank: true

end
