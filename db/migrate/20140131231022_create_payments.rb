class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount, :default => 0
      t.date :date
      t.integer :spot_id
      t.boolean :scholarship, :default => false

      t.timestamps
    end
  end
end
