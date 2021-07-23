# frozen_string_literal: true

module Types
  class CMECreditHourType < Types::BaseObject
    field :activity_date, GraphQL::Types::ISO8601DateTime, null: false
    field :activity_name, String, null: false
    field :hours_earned, Float, null: false
    field :method_of_education, String, null: false
    field :person, Types::PersonType, null: false
    field :sponsor_name, String, null: true
  end
end
