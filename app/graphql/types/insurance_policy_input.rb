# frozen_string_literal: true

module Types
  class InsurancePolicyInput < Types::BaseInputObject
    description "Input to create or edit insurance policies"
    argument :aggregate_amount, Float, required: false
    argument :city, String, required: false
    argument :claims_coverage_type, Types::ClaimsCoverageTypeEnum, required: false
    argument :coverage_type, Types::CoverageTypeEnum, required: false
    argument :covered_by_ftca, Boolean, required: true
    argument :email, String, required: false
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :entity_name, String, required: false
    argument :fax_number, String, required: false
    argument :per_claim_amount, Float, required: false
    argument :phone_number, String, required: false
    argument :policy_number, String, required: false
    argument :self_insured, Boolean, required: true
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :state, String, required: false
    argument :street_address, String, required: false
    argument :tail_coverage, Boolean, required: true
    argument :url, String, required: false
    argument :zip_code, String, required: false
  end
end
