class AddHospitalRefToBloodRequets < ActiveRecord::Migration[8.1]
  def change
    add_reference :blood_requests, :hospital, null: false, foreign_key: true
  end
end
