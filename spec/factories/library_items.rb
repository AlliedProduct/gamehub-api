FactoryBot.define do
  factory :library_item do
    association :user
    association :game
    status { %w[playing completed backlog wishlist dropped].sample }
  end
end