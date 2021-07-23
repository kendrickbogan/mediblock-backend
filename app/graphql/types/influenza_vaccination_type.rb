# frozen_string_literal: true

module Types
  class InfluenzaVaccinationType < Types::BaseObject
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :facility_name, String, null: true
    field :flu_season, String, null: true
    field :has_been_vaccinated, Boolean, null: false
    field :no_vaccination_comment, String, null: true
    field :person, Types::PersonType, null: false
    field :state, String, null: true
    field :vaccinated_at, GraphQL::Types::ISO8601DateTime, null: true
    field :zip, String, null: true
  end
end
