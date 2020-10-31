class AddIcsUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ics_url, :string
  end
end
