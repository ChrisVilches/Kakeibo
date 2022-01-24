module Queries
  module Periods
    class List < BaseQuery
      type [Types::PeriodType], null: false

      def resolve
        # TODO: N+1 when including days.
        current_user.periods.includes(days: :expenses).order(created_at: :desc)
      end
    end
  end
end
