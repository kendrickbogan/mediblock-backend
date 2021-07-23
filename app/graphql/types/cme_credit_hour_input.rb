# frozen_string_literal: true

module Types
  class CMECreditHourInput < Types::BaseInputObject
    description "Input to create or edit CME credit hours"
    argument :activity_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :activity_name, String, required: false
    argument :hours_earned, Float, required: true
    argument :method_of_education, String, required: false
    argument :sponsor_name, String, required: false
  end
end
