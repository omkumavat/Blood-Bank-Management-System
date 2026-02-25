class BloodStock < ApplicationRecord
  belongs_to :blood_bank


  

  
  validates :blood_group, :quantity, :size,
            presence: { message: "cannot be blank" }

  
  validates :blood_group,
            inclusion: {
              in: %w[A+ A- B+ B- AB+ AB- O+ O- Rh+ Rh-],
              message: "must be a valid blood group (A+, A-, B+, B-, AB+, AB-, O+, O-, Rh+, Rh-)"
            }

 
  validates :quantity,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              message: "must be a non-negative whole number"
            }

 
  validates :size,
            numericality: {
              only_integer: true,
              greater_than: 0,
              message: "must be a positive number"
            }


end
