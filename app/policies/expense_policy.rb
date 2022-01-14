class ExpensePolicy < ApplicationPolicy
  def destroy?
    record.day.period.user_id == user.id
  end
end
