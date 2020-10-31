class AddTwitchIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitch_id, :string
    add_index :users, :twitch_id
  end
end
