module Mutations
  class CreateExpense < BaseMutation
    type Types::DayType
    argument :period_id, ID, required: true
    argument :day_date, GraphQL::Types::ISO8601Date, required: true
    argument :cost, Integer, required: false
    argument :label, String, required: false

    def resolve(period_id:, day_date:, cost: nil, label: nil)
      ActiveRecord::Base.transaction do
        period = current_user.periods.find period_id
        day = period.days.find_by day_date: day_date

        # TODO: Another controller is also using this, so move to services/business folder (maybe).
        day = period.days.create day_date: day_date if day.nil?

        params = { label: label, cost: cost }.compact

        raise HttpErrors::UnprocessableEntityError, day unless day.expenses.create(params)

        day
      end
    end
  end
end
