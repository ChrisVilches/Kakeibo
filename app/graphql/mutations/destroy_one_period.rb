module Mutations
  class DestroyOnePeriod < BaseMutation
    type Types::PeriodType
    argument :id, ID, required: true

    # TODO: I'd like it to be executable without having to name the mutation like so: "mutation A($input: InputObjectEtc)"
    def resolve(id:)
      period = current_user.periods.find id
      period.destroy!
    end
  end
end
