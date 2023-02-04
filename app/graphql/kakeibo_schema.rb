class KakeiboSchema < GraphQL::Schema
  include Pundit::Authorization

  rescue_from(ActiveRecord::RecordNotFound) do
    # Message has to be changed, otherwise it will contain SQL code explaining
    # why it wasn't found.
    raise GraphQL::ExecutionError, 'resource was not found'
  end

  rescue_from(ActiveRecord::RecordInvalid) do |err|
    raise GraphQL::ExecutionError, err
  end

  rescue_from(Pundit::NotAuthorizedError) do |err|
    # When Pundit::NotAuthorizedError is raised without a message,
    # a buggy message appears by default containing the string 'NilClass'.
    # Therefore, convert it to a more readable message.
    err = Pundit::NotAuthorizedError.new 'not allowed' if err.message.include? 'NilClass'

    raise GraphQL::ExecutionError, err
  end

  mutation(Types::MutationType)
  query(Types::QueryType)
end
