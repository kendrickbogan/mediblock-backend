# frozen_string_literal: true

module Types
  class MalpracticeClaimInput < Types::BaseInputObject
    description "Input to create or edit malpractice claims"
    argument :alleged_incident_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :amount_paid, Float, required: true
    argument :claim_filed_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :claim_status, String, required: false
    argument :defendant_type, Types::MalpracticeDefendantEnum, required: true
    argument :description_of_allegations, String, required: false
    argument :description_of_alleged_injury, String, required: false
    argument :included_in_npdb, Boolean, required: true
    argument :insurance_carrier_involved, String, required: false
    argument :involvement_description, String, required: false
    argument :method_of_resolution, Types::MalpracticeResolutionEnum, required: true
    argument :number_of_co_defendants, Integer, required: true
    argument :policy_number_covered_by, String, required: false
    argument :resolution_comment, String, required: false
    argument :settlement_amount, Float, required: true
  end
end
