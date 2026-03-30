class RemoveSizeFromBloodStock < ActiveRecord::Migration[8.1]
  def change
    remove_column :blood_stocks, :size, :integer
  end
end
