class AuthorizedController < ApplicationController
  #before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  include Pundit

  def current_user
    @current_user ||= User.first
  end

  private

  def user_not_authorized
    render json: { message: 'You are not authorized to perform this action.' }, status: :unauthorized
  end
end
