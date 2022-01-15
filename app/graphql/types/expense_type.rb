module Types
  class ExpenseType < Types::BaseObject
    field :id, ID, null: false
    field :label, String, null: false
    field :cost, Integer, null: false
    field :day_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
