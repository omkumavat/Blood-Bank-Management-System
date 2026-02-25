class DonationAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :blood_bank
end
