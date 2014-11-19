class AddActivationDigestToDirecciones < ActiveRecord::Migration
  def change
    add_column :direcciones, :activation_digest, :string
    add_column :direcciones, :activated, :boolean, default: false
  end
end
