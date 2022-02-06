FactoryBot.define do
  factory :tag do
    value { Faker::Lorem.sentence(word_count: 2) }    
  end
end
