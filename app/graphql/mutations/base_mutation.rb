module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    null false
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def self.default_graphql_name
      @default_graphql_name ||= name.split('::')[1..-1].join
    end

    private

    def current_user
      context[:current_user]
    end
  end
end
