module Queries
  module Periods
    class Show < BaseQuery
      type Types::PeriodType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        current_user.periods.includes(:days).find(id)
      end
    end
  end
end
