class UsersController < ApplicationController
  def me
    render json: current_user, status: :ok
  end
end
