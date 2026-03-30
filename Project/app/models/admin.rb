class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :role, presence: true, inclusion: 
            { in: ['superadmin', 'bb_admin', 'hospital_admin'] }
end
