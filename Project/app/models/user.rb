class User < ApplicationRecord
  has_many :donation_appointments
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :email, presence: true
  validates :phone_number, presence: true, numericality: { 
    
    only_integer: true
   }
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :pincode, presence: true
  validates :blood_group, presence: true


end
