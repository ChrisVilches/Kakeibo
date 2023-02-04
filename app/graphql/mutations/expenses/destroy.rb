module Mutations
  module Expenses
    include Pundit::Authorization

    class Destroy < BaseMutation
      type Types::ExpenseType
      argument :id, ID, required: true

      def resolve(id:)
        expense = Expense.find id

        raise Pundit::NotAuthorizedError unless ExpensePolicy.new(current_user, expense).discard?

        expense.discard
        expense
      end
    end
  end
end
