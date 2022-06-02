FactoryBot.define do
  factory :item do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.word }
  end
end