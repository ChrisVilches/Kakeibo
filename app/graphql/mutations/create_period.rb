module Mutations
  class CreatePeriod < BaseMutation
    type Types::PeriodType
    argument :name, String, required: true
    argument :date_from, GraphQL::Types::ISO8601Date, required: true
    argument :date_to, GraphQL::Types::ISO8601Date, required: true

    # TODO: Where do I use the PeriodInputType class I created?
    def resolve(name:, date_from:, date_to:)
      period = current_user.periods.build({
                                            name:      name,
                                            date_from: date_from,
                                            date_to:   date_to
                                          })

      # TODO: Probably should not be called "http"
      #       Can it work just by raising the default error that save! throws?
      raise HttpErrors::UnprocessableEntityError, period unless period.save

      period
    end
  end
end
