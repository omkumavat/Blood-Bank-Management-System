class CreateDonationAppointment < ActiveRecord::Migration[8.1]
  def change
    create_table :donation_appointments do |t|
      t.date :scheduled_date
      t.time :scheduled_time_start
      t.time :scheduled_time_end
      t.string :status

      t.timestamps
    end
  end
end
