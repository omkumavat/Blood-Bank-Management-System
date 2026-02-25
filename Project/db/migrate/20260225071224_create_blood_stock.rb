class CreateBloodStock < ActiveRecord::Migration[8.1]
  def change
    create_table :blood_stocks do |t|
      t.string :type_blood
      t.integer :quantity
      t.integer :size

      t.timestamps
    end
  end
end
