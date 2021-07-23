# frozen_string_literal: true

module Types
  class ProfessionalLicenseInput < Types::BaseInputObject
    description "Input to create or edit professional licenses"
    argument :issuing_state, String, required: false
    argument :issuing_authority, String, required: false
    argument :number, String, required: false
    argument :license_verification_url, String, required: true
    argument :date_of_issue, GraphQL::Types::ISO8601DateTime, required: true
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :status, String, required: false
    argument :unrestricted_license, Boolean, required: true
    argument :non_medical_license_kind, String, required: false
  end
end
