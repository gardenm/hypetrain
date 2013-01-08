class AddRdioInfoToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :link, :string
    add_column :albums, :player, :string
    add_column :albums, :icon, :string
  end
end
