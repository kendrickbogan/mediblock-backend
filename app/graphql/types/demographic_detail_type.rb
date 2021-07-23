# frozen_string_literal: true

module Types
  class DemographicDetailType < Types::BaseObject
    field :race, [Types::RaceEnum], null: false
    field :ethnicity, Types::EthnicityEnum, null: false
  end
end
