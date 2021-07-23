# frozen_string_literal: true

module Types
  class DEALicenseType < Types::ObjectWithExpiration
    field :person, Types::PersonType, null: false
    field :registration_number, String, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
    field :status, String, null: false
    field :unrestricted, Boolean, null: false
  end
end
