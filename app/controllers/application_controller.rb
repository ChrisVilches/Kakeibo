class ApplicationController < ActionController::API
  rescue_from HttpErrors::UnprocessableEntityError, with: :render_unprocessable_entity
  rescue_from HttpErrors::NotFoundError, with: :render_not_found

  def current_user
    User.first
  end

  private

  def render_unprocessable_entity(err)
    render json: err.messages, status: :unprocessable_entity
  end

  def render_not_found
    head :not_found
  end
end
