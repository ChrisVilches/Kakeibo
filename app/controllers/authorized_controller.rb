class AuthorizedController < ActionController::API
  before_action :authenticate_user!
  include Pundit
end
