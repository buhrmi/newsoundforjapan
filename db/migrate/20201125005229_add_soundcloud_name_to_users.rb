class AddSoundcloudNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :soundcloud_playlist_id, :string
  end
end
