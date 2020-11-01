class AddTwitterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_id, :integer
    add_index :users, :twitter_id
    add_column :users, :twitter_name, :string
    add_index :users, :twitter_name
  end
end
