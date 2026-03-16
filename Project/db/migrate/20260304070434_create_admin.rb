class CreateAdmin < ActiveRecord::Migration[8.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
