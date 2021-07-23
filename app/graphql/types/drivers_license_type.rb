# frozen_string_literal: true

module Types
  class DriversLicenseType < Types::ObjectWithExpiration
    field :id, ID, null: false
    field :person, Types::PersonType, null: false
    field :number, String, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
    field :issuing_state, String, null: false
  end
end
