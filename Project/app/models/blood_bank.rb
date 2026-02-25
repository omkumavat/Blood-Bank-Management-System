class BloodBank < ApplicationRecord
  has_many :blood_stocks
  has_many :blood_requests
  has_many :donation_appointments


  validates :name, :country, :state, 
            :city, :address, :pincode,
            :phone_number, :website,
            presence: {message: "Cannot be blank!"}
  
  validates :name, :country, :state, :city, 
            format: { with: /\A[A-Za-z\s.\-']+\z/ ,
                      message: "Numbers and special characters are not allowed"}

  validates :pincode, numericality: {only_integer: true}, length: {is: 6}
  validates :phone_number,uniqueness: true ,numericality: {only_integer: true}, length: {is: 10}

  validates :website,
            format: { 
            with: URI::DEFAULT_PARSER.make_regexp(%w[https]), 
            message: "must start with https://" 
            },
            allow_blank: true

  validates :verified, inclusion: {in: [true, false], message: "%value is invalid!"}
  
  belongs_to :hospital
end
