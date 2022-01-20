module ExpenseServices
  class Create
    def initialize(current_user)
      @current_user = current_user
    end

    def execute(period_id:, day_date:, cost: nil, label: nil)
      ActiveRecord::Base.transaction do
        period = @current_user.periods.find period_id
        day = period.days.find_or_create_by day_date: day_date

        day.expenses.create!({ label: label, cost: cost }.compact)
        day
      end
    end
  end
end
