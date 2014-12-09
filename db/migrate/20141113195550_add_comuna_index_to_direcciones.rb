class AddComunaIndexToDirecciones < ActiveRecord::Migration
  def change
      add_index :direcciones, [:direccion, :numero, :bloque, :dpto, :comuna_id], unique: true, :name => 'noLaMismaDireccion'
  end
end
