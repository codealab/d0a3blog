class CreateProgramRelations < ActiveRecord::Migration
  def change
    create_table :program_relations do |t|
      t.integer :lesson_id
      t.integer :exercise_id

      t.timestamps
    end
    add_index :program_relations, [:lesson_id, :exercise_id], unique: true
  end
end