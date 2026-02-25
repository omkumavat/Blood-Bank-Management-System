class BloodBank < ApplicationRecord
  has_many :blood_stocks
  has_many :donation_appointments
  belongs_to :hospital
end
