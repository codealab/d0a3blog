class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :calle
      t.string :num_ext
      t.string :num_int
      t.string :localidad
      t.string :referencia
      t.string :colonia
      t.string :municipio
      t.string :ciudad
      t.string :estado
      t.string :pais
      t.string :codigo_postal
      t.string :telefono
      t.string :celular
      t.string :email
      t.integer :family_id

      t.timestamps
    end
  end
end