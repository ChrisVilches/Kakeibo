module Queries
  module Periods
    class List < BaseQuery
      type [Types::PeriodType], null: false

      def resolve
        # TODO: N+1 when including days. Maybe can't be fixed as long as the days are scoped.
        #       Because it's necessary to do for example:
        #       day_date >= '2021-12-24' AND day_date <= '2022-01-24'
        #
        #       Removing this line (in Period model) solves the problem:
        #       has_many :days, ->(period) { within(period.date_from, period.date_to)...
        #
        #       One way to solve it is by coding the query without ActiveRecord methods.
        current_user.periods.includes(days: :expenses).order(created_at: :desc)
      end
    end
  end
end
