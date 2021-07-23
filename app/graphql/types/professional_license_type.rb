# frozen_string_literal: true

module Types
  class ProfessionalLicenseType < Types::BaseObject
    field :id, ID, null: false
    field :person, Types::PersonType, null: false
    field :issuing_state, String, null: false
    field :issuing_authority, String, null: false
    field :number, String, null: false
    field :license_verification_url, String, null: false
    field :date_of_issue, GraphQL::Types::ISO8601DateTime, null: false
    field :expires_at, GraphQL::Types::ISO8601DateTime, null: false
    field :status, String, null: false
    field :unrestricted_license, Boolean, null: false
    field :non_medical_license_kind, String, null: true
    field :kind, Types::ProfessionalLicenseKind, null: false
  end
end
