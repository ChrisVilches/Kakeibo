module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :fetch_periods, resolver: Queries::Periods::List
    field :fetch_one_period, resolver: Queries::Periods::Show
    field :fetch_one_day, resolver: Queries::Days::Show
  end
end
