class ObservationToSpots < ActiveRecord::Migration
  def change
  	add_column :spots, :observation, :text
  end
end