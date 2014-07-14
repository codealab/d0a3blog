class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.string :name
      t.string :timezone
      t.integer :quota_per_group
      t.integer :child_age
      t.string  :logo

      t.timestamps
    end
  end
end