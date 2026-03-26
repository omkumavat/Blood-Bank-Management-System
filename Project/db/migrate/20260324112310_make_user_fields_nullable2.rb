class MakeUserFieldsNullable2 < ActiveRecord::Migration[8.1]
  def change
    change_column_null :users, :encrypted_password, true
  end
end
