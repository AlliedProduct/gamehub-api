class RemoveUserIdFromGames < ActiveRecord::Migration[8.0]
  def change
    remove_reference :games, :user, foreign_key: true
  end
end
