class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :person_id
      t.integer :lecture_id
      t.text :observation

      t.timestamps
    end
  end
end