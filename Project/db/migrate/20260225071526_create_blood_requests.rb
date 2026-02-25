class CreateBloodRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :blood_requests do |t|
      t.integer :quantity
      t.string :status
      t.integer :accepted_bb_id
      t.string :blood_group

      t.timestamps
    end
  end
end
