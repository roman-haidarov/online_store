FactoryBot.define do
  factory :user do
    email { FFaker::Lorem.word }
    password { FFaker::Lorem.word }
  end
end