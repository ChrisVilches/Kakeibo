class DaysController < ApplicationController
  def show
    period = current_user.periods.find params[:period_id]
    day = period.days.find_by! day_date: params[:day_date]

    render json: day, include: :expenses
  end

  def upsert_day
    ActiveRecord::Base.transaction do
      period = current_user.periods.find params[:period_id]
      day = period.days.find_by_day_date(params[:day_date])
      day ||= period.days.build day_date: params[:day_date]

      raise HttpErrors::UnprocessableEntityError, day unless day.update(day_params)

      render json: period, include: :days
    end
  end

  private

  def day_params
    params.require(:day).permit(:budget, :memo)
  end
end
