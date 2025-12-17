class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :rating, inclusion: 1..10
  validates :comment, length: { maximum: 2000 }, allow_blank: true
end
