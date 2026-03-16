class Hospital < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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


 validates :pincode, presence: true,
          format: { with: /\A\d{6}\z/, message: "must be 6 digits" }
  # validates :phone_number,uniqueness: true ,numericality: {only_integer: true}, length: {is: 10}
    validates :phone_number, presence: true, uniqueness: true,
          format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
          

validates :website,
          format: {
            with: URI::DEFAULT_PARSER.make_regexp(%w[https]),
            message: "must be a valid HTTPS URL (starting with https://)"
          },
          allow_blank: true

end
