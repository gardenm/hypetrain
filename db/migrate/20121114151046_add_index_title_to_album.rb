class AddIndexTitleToAlbum < ActiveRecord::Migration
  def self.up
    add_index :albums, :title
  end

  def self.down
    remove_index :albums, :title
  end
end
