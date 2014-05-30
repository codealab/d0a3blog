class CreateProgramRelations < ActiveRecord::Migration
  def change
    create_table :program_relations do |t|
      t.integer :program_id
      t.integer :exercise_id
      t.integer :lecture

      t.timestamps
    end
  end
end