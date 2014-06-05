class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :program_id
      t.integer :order_day

      t.timestamps
    end
  end
end
