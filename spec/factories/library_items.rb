FactoryBot.define do
  factory :library_item do
    user { nil }
    game { nil }
    status { "MyString" }
  end
end
