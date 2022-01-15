module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :fetch_periods, resolver: Queries::FetchPeriods
    field :fetch_one_period, resolver: Queries::FetchOnePeriod
    field :fetch_one_day, resolver: Queries::FetchOneDay
  end
end
