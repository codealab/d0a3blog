class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.boolean :administrator, :default => false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end