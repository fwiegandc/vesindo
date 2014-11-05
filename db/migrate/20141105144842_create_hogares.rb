class CreateHogares < ActiveRecord::Migration
  def change
    create_table :hogares do |t|
      t.integer :user_admin_id

      t.timestamps null: false
    end
    add_index :hogares, :user_admin_id, unique: true
  end
end
