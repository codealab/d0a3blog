class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :title #title of post
      t.integer :cover_id #Image for shares
      t.text :text, :default => "" #Post Content
      
      t.boolean :main, :default => false  #the post is importatn? set true to appear in index header?
      t.boolean :status, :default => false #administrator check the content of the post 
      t.integer :views, :default => 0 #counter for visits

      t.integer :post_type_id #content relation for post
      t.integer :user_id #user write the post

      t.text :credits, :default => "" #credits, references

      t.timestamps
    end
  end
end