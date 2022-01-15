module Mutations
  class UpsertDay < BaseMutation
    type Types::DayType
    argument :period_id, ID, required: true
    argument :budget, Integer, required: true
    argument :memo, String, required: true
    argument :day_date, GraphQL::Types::ISO8601Date, required: true

    def resolve(period_id:, day_date:, budget: nil, memo: nil)
      period = current_user.periods.includes(:days).find(period_id)

      ActiveRecord::Base.transaction do
        day = period.days.find_by_day_date(day_date)
        day ||= period.days.build day_date: day_date

        params = { budget: budget, memo: memo }.compact
        return if params.empty?

        raise HttpErrors::UnprocessableEntityError, day unless day.update(params)

        day
      end
    end
  end
end
