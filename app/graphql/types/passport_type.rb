# frozen_string_literal: true

module Types
  class PassportType < Types::ObjectWithExpiration
    field :id, String, null: false
    field :person, Types::PersonType, null: false
    field :country_of_issue, String, null: false
    field :number, String, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
