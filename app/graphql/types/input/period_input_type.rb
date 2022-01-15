module Types
  module Input
    class PeriodInputType < Types::BaseInputObject
      argument :name, String, required: true
      argument :date_from, GraphQL::Types::ISO8601Date, required: true
      argument :date_to, GraphQL::Types::ISO8601Date, required: true
    end
  end
end
