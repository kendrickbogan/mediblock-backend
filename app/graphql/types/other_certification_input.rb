# frozen_string_literal: true

module Types
  class OtherCertificationInput < Types::BaseInputObject
    description "Input to create or edit other certifications"
    argument :other_name, String, required: false
    argument :issued_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
