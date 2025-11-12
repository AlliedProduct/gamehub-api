class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :platform
      t.string :genre
      t.integer :release_year
      t.float :avg_rating, default: 0.0

      t.timestamps
    end
    add_index :games, :title
  end
end
