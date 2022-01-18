class LoginFailureApp < Devise::FailureApp
  def respond
    # TODO: Test
    if graphql_request?
      respond_graphql
    else
      respond_rest
    end
  end

  private

  def graphql_request?
    return true if(params.key?(:graphql))
    params.key?(:query) && params.key?(:variables) && params.key?(:operationName)
  end

  def respond_graphql
    self.status = 200
    self.content_type = 'application/json'
    self.response_body = create_error(message: i18n_message).to_json
  end

  def respond_rest
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { message: i18n_message }.to_json
  end
  
  def create_error(message:, extensions_code: 'NOT_AUTHORIZED')
    {
      data: nil,
      errors: [
        {
          message: message,
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
            code: extensions_code
          }
        }
      ]
    }
  end
end
