module Mutations
  module Periods
    class Update < BaseMutation
      description 'Updates a period'
      type Types::PeriodType
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :date_from, GraphQL::Types::ISO8601Date, required: false
      argument :date_to, GraphQL::Types::ISO8601Date, required: false

      def resolve(id:, name: nil, date_from: nil, date_to: nil)
        period = current_user.periods.find id

        # TODO: Missing logic for when the new range (date_from -> date_to) excludes existing days.
        #       Must delete those days.
        #       Or maybe, just leave them there (in case the user changes the range again, so that they
        #       appear again), and when rendering the period with its days, render only the ones that
        #       are currently inside the range.
        period.update!({ name: name, date_from: date_from, date_to: date_to }.compact)
        period
      end
    end
  end
end
