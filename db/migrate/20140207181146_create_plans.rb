class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :lecture_id
      t.integer :exercise_id
      t.text :material
      t.text :music

      t.timestamps
    end
    add_index :plans, [:lecture_id, :exercise_id], unique: true
  end
end
