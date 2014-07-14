class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :group_id
      t.datetime :date
      t.text :observation

      t.timestamps
    end
    add_index :lectures, [:group_id, :date], unique: true
  end
end