FactoryBot.define do
  factory :review do
    association :user
    association :game
    rating  { Faker::Number.between(from: 1, to: 10) }
    comment { Faker::Lorem.sentence(word_count: 10) }
  end
end