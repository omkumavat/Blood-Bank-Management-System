class CreateBloodRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :blood_requests do |t|
      t.integer :quantity, null: false
      t.string :status, null: false, default: "pending"
      t.integer :accepted_bb_id, null: true
      t.string :blood_group, null: false
      t.references :hospital, null: false, foreign_key: true
      t.timestamps
    end
  end
end
