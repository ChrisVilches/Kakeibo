class ExpensesCleanupJob < ApplicationJob
  queue_as :low_priority

  def perform(minutes: 10)
    Expense.discarded_before(DateTime.now - minutes.minutes).destroy_all
  end
end
