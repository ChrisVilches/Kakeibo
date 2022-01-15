module Mutations
  class UpdatePeriod < BaseMutation
    type Types::PeriodType
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :date_from, GraphQL::Types::ISO8601Date, required: false
    argument :date_to, GraphQL::Types::ISO8601Date, required: false

    def resolve(id:, name: nil, date_from: nil, date_to: nil)
      period = current_user.periods.find id

      period.name = name unless name.nil?
      period.date_from = date_from unless date_from.nil?
      period.date_to = date_to unless date_to.nil?

      raise HttpErrors::UnprocessableEntityError, period unless period.save

      period
    end
  end
end
