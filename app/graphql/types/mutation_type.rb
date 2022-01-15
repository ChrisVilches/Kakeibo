module Types
  class MutationType < Types::BaseObject
    field :create_period, mutation: Mutations::CreatePeriod
    field :destroy_one_period, mutation: Mutations::DestroyPeriod
    field :update_period, mutation: Mutations::UpdatePeriod
    field :upsert_day, mutation: Mutations::UpsertDay
    field :create_expense, mutation: Mutations::CreateExpense
    field :destroy_expense, mutation: Mutations::DestroyExpense
  end
end
