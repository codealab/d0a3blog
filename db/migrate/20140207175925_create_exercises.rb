class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :area
      t.integer :min_age
      t.integer :max_age
      t.text :objective
      t.text :description
      t.text :material
      t.text :music

      t.timestamps
    end
  end
end
