class CreateGigs < ActiveRecord::Migration[6.0]
  def change
    create_table :gigs do |t|
      t.string :external_id
      
      t.string :summary
      t.integer :event_id
      t.integer :talent_id
      
      t.timestamp :start_at
      t.timestamp :end_at

      t.boolean :featured

      t.index :external_id
      t.index :event_id
      t.index :artist_id
      t.index :start_at

      t.timestamps
    end
  end
end
