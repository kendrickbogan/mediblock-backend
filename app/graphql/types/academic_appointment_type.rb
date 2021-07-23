# frozen_string_literal: true

module Types
  class AcademicAppointmentType < Types::BaseObject
    field :person, Types::PersonType, null: false
    field :position, String, null: false

    field :institution_name, String, null: false
    field :institution_url, String, null: true
    field :address_line_1, String, null: false
    field :address_line_2, String, null: true
    field :city, String, null: false
    field :state, String, null: true
    field :zip, String, null: false
    field :country, String, null: false

    field :phone_number, String, null: true
    field :fax_number, String, null: true

    field :department_head_first_name, String, null: true
    field :department_head_last_name, String, null: true

    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
