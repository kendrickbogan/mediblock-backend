# frozen_string_literal: true

module Types
  class ExpirationType < Types::BaseObject
    field :id, String, null: false
    field :person, Types::PersonType, null: false
    field :expirable, Types::ExpirableType, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
