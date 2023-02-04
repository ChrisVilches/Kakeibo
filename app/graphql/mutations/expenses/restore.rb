module Mutations
  module Expenses
    include Pundit::Authorization

    class Restore < BaseMutation
      type Types::ExpenseType
      argument :id, ID, required: true

      def resolve(id:)
        expense = Expense.find id

        raise Pundit::NotAuthorizedError unless ExpensePolicy.new(current_user, expense).discard?

        expense.undiscard
        expense
      end
    end
  end
end
