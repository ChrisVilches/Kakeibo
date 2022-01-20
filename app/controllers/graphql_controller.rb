class GraphqlController < ActionController::API
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  #   before_action :authenticate_user!

  def execute
    render json: KakeiboSchema.execute(params[:query], **query_opts)
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def query_opts
    {
      variables: prepare_variables(params[:variables]),
      context: { current_user: current_user },
      operation_name: params[:operationName]
    }
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      JSON.parse(variables_param || '{}')
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(err)
    log_error(err)

    render json: { errors: [{ message: err.message, backtrace: err.backtrace }], data: {} },
           status: :internal_server_error
  end

  def log_error(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")
  end
end
