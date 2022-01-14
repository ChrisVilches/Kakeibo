class ExpensesController < ApplicationController
  def upsert_expense
    ActiveRecord::Base.transaction do
      period = current_user.periods.find params[:period_id]
      day = period.days.find_by! day_date: params[:day_date]

      raise HttpErrors::UnprocessableEntityError, day unless day.expenses.create(expense_params)

      render json: day, include: :expenses
    end
  end

  def destroy
    expense = Expense.find params[:id]
    authorize expense
    expense.destroy!
    render json: expense, status: :ok
  end

  private

  def expense_params
    params.require(:expense).permit(:label, :cost)
  end
end
