class CreateResourcesPosts < ActiveRecord::Migration
  def change
    create_table :resources_posts do |t|
    	t.integer :resources_id
    	t.integer :post_id

      t.timestamps
    end
    add_index :resources_posts, [:resources_id, :post_id], unique: true
  end
end