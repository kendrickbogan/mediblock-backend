# frozen_string_literal: true

module Types
  class MedicalDegreeType < Types::BaseObject
    field :id, ID, null: false
    field :person, Types::PersonType, null: false
    field :institution_name, String, null: false
    field :kind, Types::MedicalDegreeKind, null: false
    field :date_of_graduation, GraphQL::Types::ISO8601DateTime, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: false
    field :registrar_phone_number, String, null: false
    field :registrar_url, String, null: false
    field :foreign_medical_school, Boolean, null: false
    field :ecfmg_certified, Boolean, null: false
    field :ecfmg_certified_at, GraphQL::Types::ISO8601DateTime, null: true
    field :institution_address_line_1, String, null: false
    field :institution_address_line_2, String, null: true
    field :institution_address_line_3, String, null: true
    field :institution_address_city, String, null: false
    field :institution_address_state, String, null: false
    field :institution_address_zip, String, null: false
    field :institution_address_country, String, null: false
  end
end
