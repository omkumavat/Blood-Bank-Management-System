class BloodRequest < ApplicationRecord
  belongs_to :hospital
  belongs_to :blood_bank 

  validates :quantity, numericality: {only_integer: true, message: "Quantity must be integer"}
  validates :status, presence: true, inclusion: { in: %w(pending fulfilled),
              message: "%{value} is not a valid size" }
  
  validates :blood_group, presence: true, inclusion: { in: ['A+', 'A-', 'B+', 'B-', 'AB+', 
  'AB-', 'O+', 'O-', 'Rh-', 'Rh+'], message "%{value} is not a valid blood group" }

end
