class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string	:title
      t.text    :description
      t.string	:photo_path
      t.string	:resource_type
      t.string	:file_url

      t.timestamps
    end
  end
end