# frozen_string_literal: true

module Types
  class MedicalGroupEmployerType < Types::BaseObject
    field :person, Types::PersonType, null: false

    field :name, String, null: false
    field :legal_business_name, String, null: true
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :country, String, null: true
    field :zip, String, null: true
    field :phone_number, String, null: true
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
