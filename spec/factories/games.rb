FactoryBot.define do
  factory :game do
    title { "Test Game" }
    platform { "PC" }
    genre { "Action" }
    release_year { 2020 }
    avg_rating { nil }
  end
end
