class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :user_id
      t.integer :assistant_id
      t.string :location
      t.integer :cost
      t.date :init_date
      t.date :finish_date
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
