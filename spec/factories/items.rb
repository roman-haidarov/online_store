FactoryBot.define do
  factory :item do
    name { "#{FFaker::Lorem.word} #{rand(0..100)}" }
    description { FFaker::Lorem.word }
  end
end