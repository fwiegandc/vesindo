class CreateDirecciones < ActiveRecord::Migration
  def change
    create_table :direcciones do |t|
      t.string :direccion
      t.integer :numero
      t.string :bloque
      t.string :dpto
      t.string :villa
      t.point :loc, :srid => 3785
      t.references :hogar, index: true
      t.references :comuna, index: true

      t.timestamps
    end

    change_table :direcciones do |t|
      t.index :loc, :spatial => true
    end
  end
end
