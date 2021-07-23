# frozen_string_literal: true

module Types
  class DegreeType < Types::BaseObject
    field :id, ID, null: false
    field :kind, Types::DegreeKind, null: false
    field :person, Types::PersonType, null: false
    field :institution_name, String, null: false
    field :degree, String, null: false
    field :major, String, null: true
    field :minor, String, null: true
    field :date_of_graduation, GraphQL::Types::ISO8601DateTime, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: false
    field :registrar_phone_number, String, null: false
    field :registrar_url, String, null: false
    field :institution_address_line_1, String, null: false
    field :institution_address_line_2, String, null: true
    field :institution_address_line_3, String, null: true
    field :institution_address_city, String, null: false
    field :institution_address_state, String, null: false
    field :institution_address_zip, String, null: false
    field :institution_address_country, String, null: false
  end
end
