class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :location_id
      t.timestamp :start_at

      t.timestamps
    end
  end
end
