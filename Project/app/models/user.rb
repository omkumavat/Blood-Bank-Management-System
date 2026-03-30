class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :donation_appointments

  # Make password optional for OAuth users
  def password_required?
    provider.blank? || password.present?
  end

  def email_required?
    super && provider.blank?
  end

  # validations only for normal signup users
  # with_options unless: :oauth_user? do
    # validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }
    # validates :last_name,  presence: true, length: { minimum: 2, maximum: 50 }
    # validates :phone_number, presence: true, uniqueness: true,
    #                          format: { with: /\A\d{10}\z/, message: 'must be 10 digits' }
    # validates :pincode, presence: true,
    #                     format: { with: /\A\d{6}\z/, message: 'must be 6 digits' }
    # validates :country,  presence: true, length: { minimum: 2, maximum: 50 }
    # validates :state,    presence: true, length: { minimum: 2, maximum: 50 }
    # validates :city,     presence: true, length: { minimum: 2, maximum: 50 }
    # validates :address,  presence: true, length: { minimum: 5, maximum: 100 }
    # validates :blood_group, presence: true, inclusion: { in: ['A+', 'A-', 'B+', 'B-', 'AB+',
    #                                                           'AB-', 'O+', 'O-', 'Rh-', 'Rh+'] }
    # validates :date_of_birth, presence: true
    # validate  :must_be_18_years_old
  # end

  def oauth_user?
    provider.present?
  end

  private

  def must_be_18_years_old
    return if date_of_birth.blank?
    return unless date_of_birth > 18.years.ago.to_date
    errors.add(:date_of_birth, 'You must be at least 18 years old')
  end
end