class CreateBloodRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :blood_requests do |t|
      t.integer :quantity
      t.string :status
      t.string :blood_group
      t.references :blood_bank, null: false, foreign_key: true

      t.timestamps
    end
  end
end
