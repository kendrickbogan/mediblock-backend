# frozen_string_literal: true

require_relative "../authentication_helpers"

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include AuthenticationHelpers

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject
  end
end
