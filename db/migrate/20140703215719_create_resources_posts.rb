class CreateResourcesPosts < ActiveRecord::Migration
  def change
    create_table :resources_posts do |t|
    	t.integer :resource_id
    	t.integer :post_id

      t.timestamps
    end
    add_index :resources_posts, [:resource_id, :post_id], unique: true
  end
end