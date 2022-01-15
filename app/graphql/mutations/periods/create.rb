module Mutations
  module Periods
    class Create < BaseMutation
      type Types::PeriodType
      argument :name, String, required: true
      argument :date_from, GraphQL::Types::ISO8601Date, required: true
      argument :date_to, GraphQL::Types::ISO8601Date, required: true

      def resolve(name:, date_from:, date_to:)
        period = current_user.periods.build({
                                              name:      name,
                                              date_from: date_from,
                                              date_to:   date_to
                                            })

        period.save!
        period
      end
    end
  end
end
