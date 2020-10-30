class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :google_calendar_id
      t.string :google_access_token
      t.string :google_refresh_token
      t.timestamp :google_expires_at
      t.timestamps
    end
  end
end
