module Mutations
  include Pundit

  class DestroyExpense < BaseMutation
    type Types::ExpenseType
    argument :id, ID, required: true

    def resolve(id:)
      expense = Expense.find id

      raise Pundit::NotAuthorizedError unless ExpensePolicy.new(current_user, expense).destroy?

      expense.destroy!
    end
  end
end
