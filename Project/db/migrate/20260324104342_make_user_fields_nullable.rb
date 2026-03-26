class MakeUserFieldsNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :users, :phone_number, true
    change_column_null :users, :country, true
    change_column_null :users, :state, true
    change_column_null :users, :city, true
    change_column_null :users, :address, true
    change_column_null :users, :pincode, true
    change_column_null :users, :date_of_birth, true
    change_column_null :users, :blood_group, true
  end
end