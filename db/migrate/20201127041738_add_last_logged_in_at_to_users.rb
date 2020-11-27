class AddLastLoggedInAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_logged_in_at, :timestamp
  end
end
