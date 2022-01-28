module Mutations
  module Periods
    class Update < BaseMutation
      description 'Updates a period'
      type Types::PeriodType
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :date_from, GraphQL::Types::ISO8601Date, required: false
      argument :date_to, GraphQL::Types::ISO8601Date, required: false
      argument :daily_expenses, Integer, required: false
      argument :savings_percentage, Integer, required: false
      argument :initial_money, Integer, required: false
      argument :salary, Integer, required: false
      argument :total_fixed_expenses, Integer, required: false

      def resolve(params)
        period = current_user.periods.find params[:id]
        period.update! filter_params params
        period
      end

      private

      def filter_params(hash)
        # TODO: This slice is probably not necessary because GraphQL gem does it automatically.
        allowed = %i[name date_from date_to daily_expenses savings_percentage
                     initial_money salary total_fixed_expenses]
        hash.slice(*allowed).compact
      end
    end
  end
end
