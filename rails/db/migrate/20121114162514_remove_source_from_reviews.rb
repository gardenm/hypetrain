class RemoveSourceFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :source
  end

  def down
    add_column :reviews, :source
  end
end
