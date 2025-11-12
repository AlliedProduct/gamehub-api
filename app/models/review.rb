class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :rating, inclusion: 1..10
  validates :comment, length: { maximum: 2000 }, allow_blank: true

  after_commit :update_game_avg

  private
  def update_game_avg
    game.recalc_avg_rating!
  end
end
