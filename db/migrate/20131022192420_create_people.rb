class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :first_last_name
      t.string :second_last_name
      t.string :sex
      t.date   :dob
      t.string :family_roll
      t.string :photo

      t.timestamps
    end

    add_index :people, [ :name, :first_last_name, :second_last_name ], :unique => true
  end
end