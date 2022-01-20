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
        service = DayServices::Upsert.new(current_user)
        service.execute(
          period_id: period_id,
          day_date:  day_date,
          budget:    budget,
          memo:      memo
        )
      end
    end
  end
end
