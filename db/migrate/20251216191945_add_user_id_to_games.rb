class AddUserIdToGames < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :user, foreign_key: true
  end
end
