class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
	    t.string :name
      t.integer :min_age
      t.integer :max_age
      t.integer :lectures
      t.text :description

      t.timestamps
    end
  end
end