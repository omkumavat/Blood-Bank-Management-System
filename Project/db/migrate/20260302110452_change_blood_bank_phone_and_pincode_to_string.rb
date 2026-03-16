class ChangeBloodBankPhoneAndPincodeToString < ActiveRecord::Migration[8.1]
    def change
    change_column :blood_banks, :phone_number, :string
    change_column :blood_banks, :pincode, :string
  end
end
