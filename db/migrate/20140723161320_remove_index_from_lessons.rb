class RemoveIndexFromLessons < ActiveRecord::Migration

  def change
  	remove_index :lessons, [:program_id, :order_day]
  end

end