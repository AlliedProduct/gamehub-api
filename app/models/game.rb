class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :library_items, dependent: :destroy

  validates :title, presence: true
  validates :rating, inclusion: { in: 1..10 }, allow_nil: true

  def recalc_avg_rating!
    update!(avg_rating: reviews.average(:rating) || 0.0)
  end
end
