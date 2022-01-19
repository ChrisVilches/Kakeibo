class LoginFailureApp < Devise::FailureApp
  def respond
    # TODO: Test
    self.content_type = 'application/json'
    self.status = graphql_request? ? 200 : 401
    self.response_body = (graphql_request? ? json_graphql : json_rest).to_json
  end

  private

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
