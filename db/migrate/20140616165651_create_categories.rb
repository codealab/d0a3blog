class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :post_type_id
      t.integer :parent_id

      t.timestamps
    end
  end
end