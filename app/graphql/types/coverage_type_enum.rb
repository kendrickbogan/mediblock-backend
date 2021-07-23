# frozen_string_literal: true

module Types
  class CoverageTypeEnum < Types::BaseEnum
    value "UNKNOWN", value: "unknown"
    value "INDIVIDUAL", value: "individual"
    value "SHARED", value: "shared"
  end
end
