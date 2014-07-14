class CreateFamilyRelations < ActiveRecord::Migration
  def change
    create_table :family_relations do |t|
      t.integer :family_id
      t.integer :person_id

      t.timestamps
    end
  end
end
