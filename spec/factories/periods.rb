FactoryBot.define do
  factory :period do
    name { Faker::Company.catch_phrase }
    total_fixed_expenses { Faker::Number.between(from: 1000, to: 80_000) }
    daily_expenses { Faker::Number.between(from: 1000, to: 3000) }
    savings_percentage { Faker::Number.between(from: 0, to: 100) }
    initial_money { Faker::Number.between(from: 1_000_000, to: 2_000_000) }
    date_from { Date.today - 10 }
    date_to { Date.today + 10 }
    user
  end
end
