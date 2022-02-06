FactoryBot.define do
  factory :bank_transaction do
    total { 45.0 }
    description { Faker::Lorem.sentence(word_count: 8 )}
    posted_at { Date.today }    
  end
end
