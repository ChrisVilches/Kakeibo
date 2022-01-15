module Queries
  module Days
    class Show < BaseQuery
      type Types::DayType, null: false
      argument :period_id, ID, required: true
      argument :day_date, GraphQL::Types::ISO8601Date, required: true

      def resolve(period_id:, day_date:)
        period = current_user.periods.includes(:days).find(period_id)
        period.days.find_by! day_date: day_date
      end
    end
  end
end
