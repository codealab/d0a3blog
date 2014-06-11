class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
		t.integer :child_id
		t.integer :tutor_id
		t.integer :group_id
		t.integer :balance
		t.text :observation
		t.date :deactivated

		t.timestamps
    end

    add_index :spots, [:child_id, :group_id], unique: true
  end
end