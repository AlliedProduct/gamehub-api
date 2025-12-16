class AddStatusAndRatingToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :status, :string
    add_column :games, :rating, :integer
    add_column :games, :notes, :text
  end
end
