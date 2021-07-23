# frozen_string_literal: true

module Types
  class AdministrativeLeadershipPositionType < Types::BaseObject
    field :person, Types::PersonType, null: false
    field :title, String, null: true
    field :started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
