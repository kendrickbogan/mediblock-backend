# frozen_string_literal: true

require_relative "../authentication_helpers"

module Mutations
  class MutationWithoutInput < GraphQL::Schema::Mutation
    include AuthenticationHelpers

    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject
  end
end
