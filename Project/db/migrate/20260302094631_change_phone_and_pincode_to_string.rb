class ChangePhoneAndPincodeToString < ActiveRecord::Migration[8.1]
  def change
    change_column :users, :phone_number, :string
    change_column :users, :pincode, :string
  end
end