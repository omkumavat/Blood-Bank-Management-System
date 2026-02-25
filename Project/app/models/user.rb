class User < ApplicationRecord
  has_many :donation_appointments

  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }, allow_blank: false

  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }, allow_blank: false

  # validates :email, presence: true
  validates :phone_number, presence: true, uniqueness: true, numericality: { 
    only_integer: true
   },
   length: { is: 10 }, allow_blank: false

  validates :country, presence: true, length: { minimum: 2, maximum: 50 }, allow_blank: false

  validates :state, presence: true, length: { minimum: 2, maximum: 50 }, allow_blank: false

  validates :city, presence: true, length: { minimum: 2, maximum: 50 }, allow_blank: false

  validates :address, presence: true, length: { minimum: 5, maximum: 100 }, allow_blank: false
  validates :pincode, presence: true, numericality: { 
    only_integer: true
   },
   length: { is: 6 }, allow_blank: false

  validates :blood_group, presence: true, inclusion: { in: ['A+', 'A-', 'B+', 'B-', 'AB+', 
  'AB-', 'O+', 'O-', 'Rh-', 'Rh+'] }, allow_blank: false

  validates :date_of_birth, presence: true, allow_blank: false
  
  validate :must_be_18_years_old
 
  private

    def must_be_18_years_old
      return if date_of_birth.blank?

      if date_of_birth > 18.years.ago.to_date
        errors.add(:date_of_birth, "You must be at least 18 years old")
      end
    end

end
