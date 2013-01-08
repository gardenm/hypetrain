class CreateCritics < ActiveRecord::Migration
  def change
    create_table :critics do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
