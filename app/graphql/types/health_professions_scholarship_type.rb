# frozen_string_literal: true

module Types
  class HealthProfessionsScholarshipType < Types::BaseObject
    field :person, Types::PersonType, null: false

    field :military_branch_scholarship_sponsor, String, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
