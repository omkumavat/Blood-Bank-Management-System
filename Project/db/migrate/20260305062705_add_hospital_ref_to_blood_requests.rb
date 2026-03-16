class AddHospitalRefToBloodRequests < ActiveRecord::Migration[8.1]
  def change
    add_reference :blood_requests, :user, null: true, foreign_key: true
    change_column_null :blood_requests, :blood_bank_id, true
  end
end
