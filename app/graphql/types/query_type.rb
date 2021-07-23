# frozen_string_literal: true

require_relative "../authentication_helpers"

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include AuthenticationHelpers

    field :countries,
          [String],
          null: false,
          description: "Fetch a list of countries for use in autocomplete fields"

    def countries
      CS.countries.values
    end

    field :states,
          [String],
          null: false,
          description: "Fetch a list of states for use in autocomplete fields"

    def states
      CS.states(:US).values
    end

    field :personal_details,
          Types::PersonType,
          null: true,
          description: "Fetch personal details for the current user"

    def personal_details
      if current_user.present?
        current_user.person
      else
        raise_unauthenticated_error
      end
    end

    field :me,
          Types::UserType,
          null: true,
          description: "Fetch account details for the current user"

    def me
      current_user
    end
  end
end
