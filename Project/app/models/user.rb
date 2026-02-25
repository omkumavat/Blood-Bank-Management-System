class User < ApplicationRecord
  has_many :donation_appointments

  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }

  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }

  # validates :email, presence: true
  validates :phone_number, presence: true, uniqueness: true, numericality: { 
    only_integer: true
   },
   length: { is: 10 }

  validates :country, presence: true, length: { minimum: 2, maximum: 50 }

  validates :state, presence: true, length: { minimum: 2, maximum: 50 }

  validates :city, presence: true, length: { minimum: 2, maximum: 50 }

  validates :address, presence: true, length: { minimum: 5, maximum: 100 }
  validates :pincode, presence: true, numericality: { 
    only_integer: true
   },
   length: { is: 6 }

  validates :blood_group, presence: true, inclusion: { in: ['A+', 'A-', 'B+', 'B-', 'AB+', 
  'AB-', 'O+', 'O-', 'Rh-', 'Rh+'] }

  validates :date_of_birth, presence: true
  
  validate :must_be_18_years_old
 
  private

    def must_be_18_years_old
      return if date_of_birth.blank?

      if date_of_birth > 18.years.ago.to_date
        errors.add(:date_of_birth, "You must be at least 18 years old")
      end
    end

end
