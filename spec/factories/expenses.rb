FactoryBot.define do
  factory :expense do
    label { "#{Faker::Food.dish} - #{Faker::Food.description}" }
    cost { Faker::Number.between(from: 0, to: 100_000) }
    day
    discarded_at { nil }

    trait :discarded do
      discarded_at { DateTime.now }
    end
  end
end
