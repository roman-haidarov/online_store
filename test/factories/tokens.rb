FactoryBot.define do
  factory :token do
    user { nil }
    token { "MyString" }
    expires_in { "2022-06-09 21:23:32" }
  end
end
