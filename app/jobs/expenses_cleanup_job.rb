class ExpensesCleanupJob < ApplicationJob
  queue_as :low_priority

  def perform(minutes: 10)
    result = Expense.discarded_before(DateTime.now - minutes.minutes).destroy_all
    logger.info "Expenses cleanup (discarded +#{minutes} min ago). Deleted: #{result.count}"
  end
end
