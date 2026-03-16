class ChangePhoneAndPincodeToStringHospital < ActiveRecord::Migration[8.1]
  def change
    change_column :hospitals, :phone_number, :string
    change_column :hospitals, :pincode, :string
  end
end
