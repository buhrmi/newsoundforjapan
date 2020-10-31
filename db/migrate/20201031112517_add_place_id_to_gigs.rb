class AddPlaceIdToGigs < ActiveRecord::Migration[6.0]
  def change
    add_column :gigs, :place_id, :integer
    add_index :gigs, :place_id
  end
end
