module Types
  class MutationType < Types::BaseObject
    field :create_period, mutation: Mutations::CreatePeriod
    field :destroy_one_period, mutation: Mutations::DestroyOnePeriod
    field :update_period, mutation: Mutations::UpdatePeriod
    field :upsert_day, mutation: Mutations::UpsertDay
  end
end
