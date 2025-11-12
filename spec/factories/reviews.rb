FactoryBot.define do
  factory :review do
    user { nil }
    game { nil }
    rating { 1 }
    comment { "MyText" }
  end
end
