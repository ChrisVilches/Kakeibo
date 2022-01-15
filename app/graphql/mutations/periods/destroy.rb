module Mutations
  module Periods
    class Destroy < BaseMutation
      type Types::PeriodType
      argument :id, ID, required: true

      def resolve(id:)
        period = current_user.periods.find id
        period.destroy!
      end
    end
  end
end
