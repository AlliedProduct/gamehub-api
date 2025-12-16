class Game < ApplicationRecord
  belongs_to :user

  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :status,
            inclusion: { in: %w[playing completed on_hold dropped planning], allow_nil: true }
  validates :rating,
            numericality: { in: 1..10, allow_nil: true }

  def recalc_avg_rating!
    update!(avg_rating: reviews.average(:rating) || 0.0)
  end
end
