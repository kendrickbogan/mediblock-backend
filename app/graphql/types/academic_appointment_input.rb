# frozen_string_literal: true

module Types
  class AcademicAppointmentInput < Types::BaseInputObject
    description "Input to create or edit academic appointments"
    argument :position, String, required: true

    argument :institution_name, String, required: true
    argument :institution_url, String, required: false
    argument :address_line_1, String, required: true
    argument :address_line_2, String, required: false
    argument :city, String, required: true
    argument :state, String, required: false
    argument :zip, String, required: true
    argument :country, String, required: true
    argument :phone_number, String, required: false
    argument :fax_number, String, required: false

    argument :department_head_first_name, String, required: false
    argument :department_head_last_name, String, required: false

    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
