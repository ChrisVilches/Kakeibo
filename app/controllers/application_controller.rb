class ApplicationController < ActionController::API
  before_action :authenticate_user!
  # before_action :caca
  include Pundit
  rescue_from HttpErrors::UnprocessableEntityError, with: :render_unprocessable_entity
  rescue_from HttpErrors::NotFoundError, with: :render_not_found

  private

  def caca
    # TODO: This shouldn't execute in users/ controllers!!!!!
    raise 'asdas'
  end

  def render_unprocessable_entity(err)
    render json: err.messages, status: :unprocessable_entity
  end

  def render_not_found
    head :not_found
  end
end
