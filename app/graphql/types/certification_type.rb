# frozen_string_literal: true

module Types
  class CertificationType < Types::ObjectWithExpiration
    field :person, Types::PersonType, null: false
    field :kind, Types::CertificationKindEnum, null: false
    field :name, String, null: false
    field :issued_at, GraphQL::Types::ISO8601DateTime, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
