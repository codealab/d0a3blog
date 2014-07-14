class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount
      t.date :date
      t.integer :spot_id
      t.integer :concept_id
      t.integer :group_id, :default => nil
      t.boolean :scholarship, :default => false
      t.text :clarification

      t.timestamps
    end
  end
end