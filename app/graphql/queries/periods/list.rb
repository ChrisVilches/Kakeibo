module Queries
  module Periods
    class List < BaseQuery
      type [Types::PeriodType], null: false

      def resolve
        current_user.periods.order(created_at: :desc)
      end
    end
  end
end
