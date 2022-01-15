module Queries
  class FetchOnePeriod < Queries::BaseQuery
    type Types::PeriodType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      current_user.periods.includes(:days).find(id)
    end
  end
end
