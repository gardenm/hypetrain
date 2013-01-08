class AddIndexNameToCritic < ActiveRecord::Migration
  def self.up
    add_index :critics, :name
  end

  def self.down
    remove_index :critics, :name
  end
end
