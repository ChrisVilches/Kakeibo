module Mutations
  module Expenses
    class Create < BaseMutation
      type Types::DayType
      argument :period_id, ID, required: true
      argument :day_date, GraphQL::Types::ISO8601Date, required: true
      argument :cost, Integer, required: true
      argument :label, String, required: false

      def resolve(period_id:, day_date:, cost: nil, label: nil)
        ActiveRecord::Base.transaction do
          period = current_user.periods.find period_id
          day = period.days.find_or_create_by day_date: day_date

          day.expenses.create!({ label: label, cost: cost }.compact)
          day
        end
      end
    end
  end
end
