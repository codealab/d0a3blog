class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :password_digest
	    t.boolean  :admin, :default => false
	    t.boolean  :coordinator, :default => false
	    t.boolean  :facilitator, :default => false
	    t.string   :remember_token
      t.string   :photo

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
