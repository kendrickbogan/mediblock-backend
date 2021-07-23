# frozen_string_literal: true

module Types
  class AdministrativeLeadershipPositionsInputType < Types::BaseInputObject
    description "Input to create or edit administrative leadership positions"

    argument :title, String, required: false

    argument :started_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
