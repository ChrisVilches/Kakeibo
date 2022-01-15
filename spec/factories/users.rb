FactoryBot.define do
  factory :user do
    email { |n| "user#{n}@gmail.com" }
    password { 'qwertyuiop123' }
  end
end
