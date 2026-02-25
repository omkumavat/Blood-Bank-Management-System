class CreateBloodBank < ActiveRecord::Migration[8.1]
  def change
    create_table :blood_banks do |t|
      t.string :name, null: false
      #Ex:- :null => false
      t.string :country, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.integer :pincode, null: false
      t.integer :phone_number, null: false
      t.string :website
      t.boolean :verified, default: false
      # t.boolean :stock_available, 

      t.timestamps
    end
  end
end
