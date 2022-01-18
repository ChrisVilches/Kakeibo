class LoginFailureApp < Devise::FailureApp
  def respond
    # TODO: Test
    self.content_type = 'application/json'
    self.status = graphql_request? ? 200 : 401
    self.response_body = (graphql_request? ? json_graphql : json_rest).to_json
  end

  # TODO: What if I just return the same JSON for both rest and graphQL?
  #       Or not necessarily the same but make sure both have an error code with the same values (NOT_LOGGED_IN, etc)
  #       But they are actually not necessary for REST for now.

  private

  def error_code
    message = warden_message || default || :unauthenticated
    message.to_s.downcase.include?('expire') ? 'SIGNATURE_EXPIRED' : 'NOT_LOGGED_IN'
  end

  def graphql_request?
    return true if(params.key?(:graphql))
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
          # "locations": [
          #     {
          #         "line": 3,
          #         "column": 3
          #     }
          # ],
          # "path": [
          #     "queryName"
          # ],
          extensions: {
            code: error_code
          }
        }
      ]
    }
  end
end
