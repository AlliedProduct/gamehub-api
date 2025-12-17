class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :library_items, dependent: :destroy
  has_many :users, through: :library_items

  validates :title, presence: true

  def recalc_avg_rating!
    update!(avg_rating: reviews.average(:rating) || 0.0)
  end
end
