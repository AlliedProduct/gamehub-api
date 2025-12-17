FactoryBot.define do
  factory :library_item do
    user
    game
    status { "completed" }
    rating { 8 }
  end
end
