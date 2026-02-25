class Hospital < ApplicationRecord
  has_one :blood_bank
  has_many :blood_requests
end
