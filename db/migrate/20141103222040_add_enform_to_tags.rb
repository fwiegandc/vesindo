class AddEnformToTags < ActiveRecord::Migration
  def change
    add_column :tags, :enform, :boolean, default: false
  end
end
