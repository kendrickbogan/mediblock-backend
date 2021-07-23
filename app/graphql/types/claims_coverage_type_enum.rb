# frozen_string_literal: true

module Types
  class ClaimsCoverageTypeEnum < Types::BaseEnum
    value "UNKNOWN", value: "unknown"
    value "CLAIMS_MADE", value: "claims_made"
    value "OCCURRENCE", value: "occurrence"
  end
end
