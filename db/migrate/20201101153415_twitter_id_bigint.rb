class TwitterIdBigint < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :twitter_id, :bigint
  end
end
