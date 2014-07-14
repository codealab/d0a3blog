class AddObjectiveToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :objective, :text
  end
end