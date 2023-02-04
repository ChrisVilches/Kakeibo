module Users
  class UsersController < AuthenticatedController
    respond_to :json

    def me
      render json: current_user, status: :ok
    end
  end
end
