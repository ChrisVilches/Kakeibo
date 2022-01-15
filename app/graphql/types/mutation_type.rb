module Types
  class MutationType < Types::BaseObject
    field :upsert_day, mutation: Mutations::Days::Upsert

    field :create_period, mutation: Mutations::Periods::Create
    field :destroy_one_period, mutation: Mutations::Periods::Destroy
    field :update_period, mutation: Mutations::Periods::Update

    field :create_expense, mutation: Mutations::Expenses::Create
    field :destroy_expense, mutation: Mutations::Expenses::Destroy
  end
end
