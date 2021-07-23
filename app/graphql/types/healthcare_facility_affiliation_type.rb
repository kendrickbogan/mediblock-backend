# frozen_string_literal: true

module Types
  class HealthcareFacilityAffiliationType < Types::BaseObject
    field :person, Types::PersonType, null: false

    field :facility_name, String, null: false
    field :facility_legal_business_name, String, null: true
    field :facility_type, String, null: true
    field :department_or_division_name, String, null: true
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip_code, String, null: true
    field :country, String, null: true
    field :membership_status, Types::HealthcareFacilityMembershipStatus, null: false
    field :medical_staff_office_phone_number, String, null: true
    field :medical_staff_office_fax_number, String, null: true
    field :privilege_limitations, Boolean, null: true
    field :comments, String, null: true
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
