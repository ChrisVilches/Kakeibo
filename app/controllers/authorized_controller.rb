class AuthorizedController < ActionController::API
  #before_action :authenticate_user!
  include Pundit

  def current_user
    @current_user ||= User.first
  end
end
