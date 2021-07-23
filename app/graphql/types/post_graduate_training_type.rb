# frozen_string_literal: true

module Types
  class PostGraduateTrainingType < Types::BaseObject
    field :id, ID, null: false
    field :person, Types::PersonType, null: false
    field :institution_name, String, null: false
    field :kind, Types::PostGraduateTrainingKind, null: false
    field :attendance_start_date, GraphQL::Types::ISO8601DateTime, null: false
    field :attendance_end_date, GraphQL::Types::ISO8601DateTime, null: true
    field :director_during_first_name, String, null: true
    field :director_during_last_name, String, null: true
    field :director_contact_number, String, null: true
    field :director_contact_email, String, null: true
    field :current_program_director_last_name, String, null: true
    field :current_program_director_first_name, String, null: true
    field :program_director_address_line_1, String, null: true
    field :program_director_address_line_2, String, null: true
    field :program_director_address_line_3, String, null: true
    field :program_director_address_city, String, null: true
    field :program_director_address_state, String, null: true
    field :program_director_address_country, String, null: true
    field :program_director_address_zip, String, null: true
    field :program_admin_name, String, null: true
    field :program_admin_phone, String, null: true
    field :program_admin_email, String, null: true
    field :gme_office_email, String, null: true
    field :gme_office_phone, String, null: true
    field :gme_office_url, String, null: true
    field :fellowship_kind, String, null: true
    field :internship_kind, String, null: true
    field :residency_kind, String, null: true
    field :acgme_accredited, Boolean, null: false
    field :successfully_completed_program, Boolean, null: false
  end
end
