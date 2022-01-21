class LoginFailureApp < Devise::FailureApp
  def respond
    self.content_type = 'application/json'
    self.status = status_code
    self.response_body = (graphql_request? ? json_graphql : json_rest).to_json
  end

  private

  def status_code
    graphql_request? ? 200 : 401
  end

  def error_code
    i18n_message.downcase.include?('expire') ? :SIGNATURE_EXPIRED : :NOT_LOGGED_IN
  end

  def graphql_request?
    return true if params.key?(:graphql)

    params.key?(:query) && params.key?(:variables) && params.key?(:operationName)
  end

  def json_rest
    { message: i18n_message, code: error_code }
  end

  def json_graphql
    {
      data: nil,
      errors: [
        {
          message: i18n_message,
          extensions: { code: error_code }
        }
      ]
    }
  end
end
