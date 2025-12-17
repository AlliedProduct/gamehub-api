FactoryBot.define do
  factory :game do
    title { "Test Game" }
    platform { "PC" }
    genre { "Action" }
    status { "planning" }
    rating { 5 }
    association :user
  end
end