class AddObjectiveToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :objective, :text
  end
end
