# frozen_string_literal: true

module Types
  class PriorNameInput < Types::BaseInputObject
    description "Input to create or edit prior names"
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :name, String, required: true
    argument :comment, String, required: false
  end
end
