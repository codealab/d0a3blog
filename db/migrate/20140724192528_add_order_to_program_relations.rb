class AddOrderToProgramRelations < ActiveRecord::Migration
  def change
    add_column :program_relations, :order, :integer
  end
end
