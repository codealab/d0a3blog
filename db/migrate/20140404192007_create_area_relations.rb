class CreateAreaRelations < ActiveRecord::Migration
  def change
    create_table :area_relations do |t|
      t.integer :exercise_id
      t.integer :area_id

      t.timestamps
    end
    add_index :area_relations, [:area_id, :exercise_id], unique: true
  end
end
