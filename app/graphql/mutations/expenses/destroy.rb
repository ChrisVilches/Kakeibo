module Mutations
  module Expenses
    include Pundit

    class Destroy < BaseMutation
      type Types::ExpenseType
      argument :id, ID, required: true
      argument :undiscard, Boolean, required: false, default_value: false

      def resolve(id:, undiscard:)
        expense = Expense.find id

        raise Pundit::NotAuthorizedError unless ExpensePolicy.new(current_user, expense).discard?

        if undiscard
          expense.undiscard
        else
          expense.discard
        end

        expense
      end
    end
  end
end
