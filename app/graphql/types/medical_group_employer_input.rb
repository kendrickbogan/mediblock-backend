# frozen_string_literal: true

module Types
  class MedicalGroupEmployerInput < Types::BaseInputObject
    description "Input to create or edit medical group employers"
    argument :name, String, required: false
    argument :legal_business_name, String, required: false
    argument :address_line_1, String, required: false
    argument :address_line_2, String, required: false
    argument :city, String, required: false
    argument :state, String, required: false
    argument :country, String, required: false
    argument :zip, String, required: false
    argument :phone_number, String, required: false
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
