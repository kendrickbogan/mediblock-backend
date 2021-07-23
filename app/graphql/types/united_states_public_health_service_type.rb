# frozen_string_literal: true

module Types
  class UnitedStatesPublicHealthServiceType < Types::BaseObject
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
    field :person, Types::PersonType, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
