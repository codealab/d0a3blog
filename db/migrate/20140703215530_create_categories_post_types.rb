class CreateCategoriesPostTypes < ActiveRecord::Migration
  def change
    create_table :categories_post_types do |t|
      t.integer :category_id
      t.integer :post_type_id

      t.timestamps
    end
    add_index :categories_post_types, [:category_id, :post_type_id], unique: true
  end
end