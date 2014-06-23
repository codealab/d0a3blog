class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :cover
      t.text :body
      t.boolean :main, :default => false
      t.integer :subcategory_id
      t.integer :user_id
      t.integer :views, :default => 0

      t.timestamps
    end
  end
end