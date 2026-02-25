class CreateHospitals < ActiveRecord::Migration[8.1]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false
      #Ex:- :default =>''
      t.string :country, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.integer :phone_number, null: false
      t.integer :pincode, null: false
      t.string :website
      t.boolean :verified, default: false
      
      t.timestamps
    end
  end
end
