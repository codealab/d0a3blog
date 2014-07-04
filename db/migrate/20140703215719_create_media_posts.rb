class CreateMediaPosts < ActiveRecord::Migration
  def change
    create_table :media_posts do |t|
    	t.integer :media_id
    	t.integer :post_id

      t.timestamps
    end
    add_index :media_posts, [:media_id, :post_id], unique: true
  end
end