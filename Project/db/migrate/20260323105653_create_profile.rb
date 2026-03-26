class CreateProfile < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :mobile
      t.string :photo_url
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
