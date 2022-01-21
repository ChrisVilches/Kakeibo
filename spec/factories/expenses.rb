FactoryBot.define do
  factory :expense do
    label { 'expense label' }
    cost { 10 }
    day
    discarded_at { nil }

    trait :discarded do
      discarded_at { DateTime.now }
    end
  end
end
