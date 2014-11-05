class AddHogarToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :hogar, index: true
  end
end
