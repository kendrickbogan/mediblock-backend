# frozen_string_literal: true

module Types
  class MilitaryServiceType < Types::BaseObject
    field :id, ID, null: false
    field :person, Types::PersonType, null: false
    field :branch_of_service, String, null: false
    field :started_at, GraphQL::Types::ISO8601DateTime, null: false
    field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
    field :active_duty, Boolean, null: false
    field :has_dd214, Boolean, null: false

    def active_duty
      object.active_duty?
    end
  end
end
