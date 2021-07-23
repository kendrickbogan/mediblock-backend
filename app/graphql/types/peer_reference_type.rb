# frozen_string_literal: true

module Types
  class PeerReferenceType < Types::BaseObject
    field :person, Types::PersonType, null: false

    field :first_name, String, null: true
    field :last_name, String, null: true
    field :title, String, null: true
    field :degree, String, null: true
    field :specialty, String, null: true
    field :relationship, String, null: true
    field :phone_number, String, null: true
    field :email_address, String, null: true
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :country, String, null: true
    field :zip, String, null: true
    field :has_worked_with_in_the_past_two_years, Boolean, null: true
    field :years_known, Integer, null: true
    field :position, Integer, null: false
  end
end
