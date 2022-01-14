class PeriodsController < ApplicationController
  def index
    render json: current_user.periods
  end

  def create
    period = current_user.periods.build period_params
    raise HttpErrors::UnprocessableEntityError, period unless period.save

    render json: { period: period }, status: :ok
  end

  def destroy
    period = current_user.periods.where(id: params[:id]).first

    raise HttpErrors::NotFoundError if period.blank?

    period.destroy!
    render json: { period: period }, status: :ok
  end

  def edit_name
    period = current_user.periods.find params[:period_id]
    period.name = period_params[:name]
    raise HttpErrors::UnprocessableEntityError, period unless period.save

    render json: { period: period }, status: :ok
  end

  def edit_times
    raise NotImplementedError
  end

  private

  def period_params
    params.require(:period).permit(:name, :date_from, :date_to)
  end
end
