# frozen_string_literal: true

module Types
  class LegalGender < Types::BaseEnum
    value "MALE", value: "male"
    value "FEMALE", value: "female"
    value "NOT_KNOWN", value: "not_known"
    value "NOT_APPLICABLE", value: "not_applicable"
  end
end
