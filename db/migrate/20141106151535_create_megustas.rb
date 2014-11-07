class CreateMegustas < ActiveRecord::Migration
  def change
    create_table :megustas do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.boolean :megusta, default: true

      t.timestamps null: false
    end
    add_index :megustas, [:post_id, :user_id], unique: true
  end
end
