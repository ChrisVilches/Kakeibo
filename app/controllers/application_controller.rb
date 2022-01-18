class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  private

  def handle_invalid_record(err)
    result = { message: err.record.errors.full_messages }

    result[:backtrace] = err.backtrace if Rails.env.development?

    render json: result, status: :unprocessable_entity
  end
end
