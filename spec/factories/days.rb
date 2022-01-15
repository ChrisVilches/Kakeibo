FactoryBot.define do
  factory :day do
    period
    day_date { period.date_from }
  end
end
