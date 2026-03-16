class CreateBloodStock < ActiveRecord::Migration[8.1]
  def change
    create_table :blood_stocks do |t|
      t.string :blood_group, null: false
      t.integer :quantity, null: false
      t.integer :size, null: false
      t.references :blood_bank, null: false, foreign_key: true
      t.timestamps
    end
  end
end
