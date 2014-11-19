class AddPermitidoEnHogarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permitido_en_hogar, :boolean, default: false
  end
end
