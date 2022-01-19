module Users
  class UsersController < AuthorizedController
    respond_to :json

    def me
      render json: current_user, status: :ok
    end
  end
end
