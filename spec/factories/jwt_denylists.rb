FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2025-11-12 15:01:03" }
  end
end
