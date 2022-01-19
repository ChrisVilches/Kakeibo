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

      def resolve(params)
        period = current_user.periods.find params[:id]

        # TODO: Missing logic for when the new range (date_from -> date_to) excludes existing days.
        #       Must delete those days.
        #       Or maybe, just leave them there (in case the user
        #       changes the range again, so that they
        #       appear again), and when rendering the period with its days,
        #       render only the ones that
        #       are currently inside the range.
        period.update! filter_params params
        period
      end

      private

      def filter_params(hash)
        allowed = %i[name date_from date_to daily_expenses savings_percentage initial_money salary]
        hash.slice(*allowed).compact
      end
    end
  end
end
