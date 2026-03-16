class AddAllowedToUsersToBloodRequests < ActiveRecord::Migration[8.1]
  def change
    add_column :blood_requests, :allowed_to_users, :boolean
  end
end
