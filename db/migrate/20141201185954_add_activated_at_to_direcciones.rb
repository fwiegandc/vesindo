class AddActivatedAtToDirecciones < ActiveRecord::Migration
  def change
    add_column :direcciones, :activated_at, :datetime
  end
end
