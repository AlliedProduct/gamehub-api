class LibraryItem < ApplicationRecord
  belongs_to :user
  belongs_to :game

  STATUSES = %w[playing completed on_hold dropped planning].freeze

  validates :status, inclusion: { in: STATUSES, allow_nil: true }
  validates :rating, numericality: { in: 1..10, allow_nil: true }
  validates :game_id, uniqueness: { scope: :user_id }

after_save :update_game_avg
after_destroy :update_game_avg

private

def update_game_avg
  game.recalc_avg_rating_from_library_items!
end
end
