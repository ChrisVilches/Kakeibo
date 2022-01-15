module Types
  class DayType < Types::BaseObject
    field :id, ID, null: false
    field :memo, String, null: true
    field :budget, Integer, null: true
    field :day_date, GraphQL::Types::ISO8601Date, null: false
  end
end
