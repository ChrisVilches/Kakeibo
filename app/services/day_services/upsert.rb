module DayServices
  class Upsert
    def initialize(current_user)
      @current_user = current_user
    end

    def execute(period_id:, day_date:, budget: nil, memo: nil)
      period = @current_user.periods.includes(:days).find(period_id)

      ActiveRecord::Base.transaction do
        day = period.days.find_or_create_by(day_date:)
        day.update!({ memo: }.compact.merge(budget:))
        day
      end
    end
  end
end
