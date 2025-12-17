class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :library_items, dependent: :destroy
  has_many :users, through: :library_items

  validates :title, presence: true

  def recalc_avg_rating_from_library_items!
    avg = library_items.where.not(rating: nil).average(:rating)&.to_f
    update_column(:avg_rating, avg)
  end
end
