FactoryBot.define do
  factory :game do
    title        { Faker::Game.title }
    platform     { %w[PC PS5 Switch Xbox].sample }
    genre        { %w[RPG Action Adventure Strategy Indie].sample }
    release_year { Faker::Number.between(from: 1995, to: 2025) }
    avg_rating   { 0.0 }
  end
end
