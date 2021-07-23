# frozen_string_literal: true

module Types
  class HospitalAffiliationType < Types::BaseObject
    field :person, Types::PersonType, null: false

    field :hospital_name, String, null: true
    field :hospital_legal_business_name, String, null: true
    field :department_name, String, null: true
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :country, String, null: true
    field :zip_code, String, null: true
    field :membership_status, Types::HospitalMembershipStatus, null: false
    field :staff_office_phone_number, String, null: true
    field :staff_office_fax_number, String, null: true
    field :privilege_limitations, Boolean, null: true
    field :comments, String, null: true
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
