# frozen_string_literal: true

module Types
  class EmploymentGapType < Types::BaseObject
    field :person, Types::PersonType, null: false
    field :text, String, null: true
  end
end
