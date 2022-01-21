module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    def self.default_graphql_name
      @default_graphql_name ||= name.split('::')[1..].join
    end

    private

    def current_user
      context[:current_user]
    end
  end
end
