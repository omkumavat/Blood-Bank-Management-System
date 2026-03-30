# frozen_string_literal: true

class BloodBank < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :blood_stocks, dependent: :destroy
  has_many :blood_requests, dependent: :destroy
  has_many :donation_appointments, dependent: :destroy

  validates :name, :country, :state,
            :city, :address, :pincode,
            :phone_number,
            presence: { message: 'Cannot be blank!' }

  validates :name, :country, :state, :city,
            format: { with: /\A[A-Za-z\s.\-']+\z/,
                      message: 'Numbers and special characters are not allowed' }

  # validates :pincode, numericality: {only_integer: true}, length: {is: 6}
  validates :pincode, presence: true,
                      format: { with: /\A\d{6}\z/, message: 'must be 6 digits' }
  # validates :phone_number,uniqueness: true ,numericality: {only_integer: true}, length: {is: 10}
  validates :phone_number, presence: true, uniqueness: true,
                           format: { with: /\A\d{10}\z/, message: 'must be 10 digits' }

  validates :website,
            format: {
              with: URI::DEFAULT_PARSER.make_regexp(%w[https]),
              message: 'must start with https://'
            },
            allow_blank: true

  validates :verified, inclusion: { in: [true, false], message: '%value is invalid!' }

  belongs_to :hospital, optional: true
end
