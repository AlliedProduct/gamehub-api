class LibraryItem < ApplicationRecord
  belongs_to :user
  belongs_to :game
  STATUSES = %w[playing completed backlog wishlist dropped].freeze
  validates :status, inclusion: { in: STATUSES }
  validates :game_id, uniqueness: { scope: :user_id }
end
