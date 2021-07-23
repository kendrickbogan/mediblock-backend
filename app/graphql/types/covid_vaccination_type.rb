# frozen_string_literal: true

module Types
  class COVIDVaccinationType < Types::BaseObject
    field :person, Types::PersonType, null: false
    field :vaccination_date_1, GraphQL::Types::ISO8601DateTime, null: false
    field :vaccination_date_2, GraphQL::Types::ISO8601DateTime, null: false
    field :facility_name, String, null: false
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, String, null: true
  end
end
