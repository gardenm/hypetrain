class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :source
      t.string :link
      t.string :description
      t.date :pub_date
      t.references :album
      t.references :critic

      t.timestamps
    end
    add_index :reviews, :album_id
    add_index :reviews, :critic_id
  end
end
