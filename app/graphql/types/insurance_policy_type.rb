# frozen_string_literal: true

module Types
  class InsurancePolicyType < Types::BaseObject
    field :aggregate_amount, Float, null: false
    field :city, String, null: true
    field :claims_coverage_type, Types::ClaimsCoverageTypeEnum, null: true
    field :coverage_type, Types::CoverageTypeEnum, null: true
    field :covered_by_ftca, Boolean, null: false
    field :email, String, null: true
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
    field :entity_name, String, null: true
    field :fax_number, String, null: true
    field :per_claim_amount, Float, null: false
    field :person, Types::PersonType, null: false
    field :phone_number, String, null: true
    field :policy_number, String, null: true
    field :self_insured, Boolean, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :state, String, null: true
    field :street_address, String, null: true
    field :tail_coverage, Boolean, null: false
    field :url, String, null: true
    field :zip_code, String, null: true
  end
end
