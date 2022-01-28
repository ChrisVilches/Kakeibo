module Types
  class PeriodType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :days, [Types::DayType], null: false
    field :date_from, GraphQL::Types::ISO8601Date, null: false
    field :date_to, GraphQL::Types::ISO8601Date, null: false
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :total_fixed_expenses, Integer, null: false
    field :daily_expenses, Integer, null: false
    field :savings_percentage, Integer, null: false
    field :initial_money, Integer, null: false
    field :salary, Integer, null: false
  end
end
