module Mutations
  module Days
    class Upsert < BaseMutation
      description 'Inserts or updates a day'
      type Types::DayType
      argument :period_id, ID, required: true
      argument :budget, Integer, required: true
      argument :memo, String, required: true
      argument :day_date, GraphQL::Types::ISO8601Date, required: true

      def resolve(period_id:, day_date:, budget: nil, memo: nil)
        period = current_user.periods.includes(:days).find(period_id)

        ActiveRecord::Base.transaction do
          day = period.days.find_or_create_by(day_date: day_date)
          day.update!({ budget: budget, memo: memo }.compact)
          day
        end
      end
    end
  end
end
