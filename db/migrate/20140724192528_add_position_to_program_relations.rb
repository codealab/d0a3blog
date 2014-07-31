class AddPositionToProgramRelations < ActiveRecord::Migration
  def change
    add_column :program_relations, :position, :integer
  end
end
