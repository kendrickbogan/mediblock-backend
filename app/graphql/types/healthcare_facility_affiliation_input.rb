# frozen_string_literal: true

module Types
  class HealthcareFacilityAffiliationInput < Types::BaseInputObject
    description "Input to create or edit healthcare affiliations"
    argument :facility_name, String, required: true
    argument :facility_legal_business_name, String, required: false
    argument :facility_type, String, required: false
    argument :department_or_division_name, String, required: false
    argument :address_line_1, String, required: false
    argument :address_line_2, String, required: false
    argument :city, String, required: false
    argument :state, String, required: false
    argument :country, String, required: false
    argument :zip_code, String, required: false
    argument :membership_status, Types::HealthcareFacilityMembershipStatus, required: true
    argument :medical_staff_office_phone_number, String, required: false
    argument :medical_staff_office_fax_number, String, required: false
    argument :privilege_limitations, Boolean, required: false
    argument :comments, String, required: false
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
