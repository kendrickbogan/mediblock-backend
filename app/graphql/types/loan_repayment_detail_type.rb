# frozen_string_literal: true

module Types
  class LoanRepaymentDetailType < Types::BaseObject
    field :person, Types::PersonType, null: false
    field :repayment_program_name, String, null: true
    field :name_of_institution, String, null: true
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, String, null: true
    field :years_worked_for_repayment, Integer, null: true
    field :started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
