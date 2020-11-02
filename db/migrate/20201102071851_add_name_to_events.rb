class AddNameToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :name, :string
    rename_column :events, :location_id, :place_id
  end
end
