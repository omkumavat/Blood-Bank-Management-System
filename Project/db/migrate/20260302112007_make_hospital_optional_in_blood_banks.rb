class MakeHospitalOptionalInBloodBanks < ActiveRecord::Migration[8.1]
  def change
    change_column_null :blood_banks, :hospital_id, true
  end
end