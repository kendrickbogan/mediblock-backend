# frozen_string_literal: true

module Types
  class RaceEnum < Types::BaseEnum
    value "WHITE", value: DemographicDetail::RACES[:white]
    value "BLACK_OR_AFRICAN_AMERICAN", value: DemographicDetail::RACES[:black_or_african_american]
    value "AMERICAN_INDIAN_OR_ALASKA_NATIVE", value: DemographicDetail::RACES[:american_indian_or_alaska_native]
    value "ASIAN", value: DemographicDetail::RACES[:asian]
    value "NATIVE_HAWAIIAN_OR_OTHER", value: DemographicDetail::RACES[:native_hawaiian_or_other_pacific_islander]
  end
end
