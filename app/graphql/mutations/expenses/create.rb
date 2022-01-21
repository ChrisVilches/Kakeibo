module Mutations
  module Expenses
    class Create < BaseMutation
      type Types::DayType
      argument :period_id, ID, required: true
      argument :day_date, GraphQL::Types::ISO8601Date, required: true
      argument :cost, Integer, required: true
      argument :label, String, required: false

      def resolve(period_id:, day_date:, cost: nil, label: nil)
        service = ExpenseServices::Create.new(current_user)
        service.execute(period_id:, day_date:, cost:, label:)
      end
    end
  end
end
