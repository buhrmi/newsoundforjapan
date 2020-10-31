class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :google_place_id
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
