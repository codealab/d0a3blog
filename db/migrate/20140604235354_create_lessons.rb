class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :program_id
      t.integer :order_day

      t.timestamps
    end
    # add_index :lessons, [:program_id, :order_day], unique: true
  end
end