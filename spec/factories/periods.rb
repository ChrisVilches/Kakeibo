FactoryBot.define do
  factory :period do
    name { 'my period' }
    daily_expenses { 10 }
    savings_percentage { 10 }
    initial_money { 1_000_000 }
    date_from { Date.today - 10 }
    date_to { Date.today + 2 }
    user
  end
end
