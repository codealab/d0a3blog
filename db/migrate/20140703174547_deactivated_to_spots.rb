class DeactivatedToSpots < ActiveRecord::Migration
  def change
  	add_column :spots, :deactivated, :date
  end
end