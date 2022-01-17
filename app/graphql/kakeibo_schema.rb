class KakeiboSchema < GraphQL::Schema
  include Pundit

  # TODO: Test
  rescue_from(ActiveRecord::RecordInvalid) do |err|
    raise GraphQL::ExecutionError, err
  end

  # TODO: Test
  rescue_from(Pundit::NotAuthorizedError) do |err|
    raise GraphQL::ExecutionError, err
  end

  mutation(Types::MutationType)
  query(Types::QueryType)
end
