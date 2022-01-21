module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      if resource.id.present?
        render json: { message: I18n.t('devise.sessions.signed_in') }, status: :ok
      else
        render json: { message: I18n.t('devise.failure.unauthenticated') }, status: :unauthorized
      end
    end

    def respond_to_on_destroy
      if current_user
        log_out_success
      else
        log_out_failure
      end
    end

    def log_out_success
      render json: { message: I18n.t('devise.sessions.signed_out') }, status: :ok
    end

    def log_out_failure
      render json: { message: I18n.t('devise.sessions.already_signed_out') }, status: :unauthorized
    end
  end
end
