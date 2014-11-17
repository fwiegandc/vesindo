class CreateComunas < ActiveRecord::Migration
  def change
    create_table :comunas do |t|
      t.string :name

      t.timestamps
    end
    add_index :comunas, :name, unique: true
  end
end
