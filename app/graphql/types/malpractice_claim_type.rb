# frozen_string_literal: true

module Types
  class MalpracticeClaimType < Types::BaseObject
    field :alleged_incident_date, GraphQL::Types::ISO8601DateTime, null: false
    field :amount_paid, Float, null: true
    field :claim_filed_at, GraphQL::Types::ISO8601DateTime, null: false
    field :claim_status, String, null: true
    field :defendant_type, Types::MalpracticeDefendantEnum, null: true
    field :description_of_allegations, String, null: true
    field :description_of_alleged_injury, String, null: true
    field :included_in_npdb, Boolean, null: true
    field :insurance_carrier_involved, String, null: true
    field :involvement_description, String, null: true
    field :method_of_resolution, Types::MalpracticeResolutionEnum, null: true
    field :number_of_co_defendants, Integer, null: false
    field :person, Types::PersonType, null: false
    field :policy_number_covered_by, String, null: true
    field :resolution_comment, String, null: true
    field :settlement_amount, Float, null: true
  end
end
