class AddIndexNameToArtist < ActiveRecord::Migration
  def self.up
    add_index :artists, :name
  end

  def self.down
    remove_index :artists, :name
  end
end
