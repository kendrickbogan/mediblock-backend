# frozen_string_literal: true

module Types
  class LanguageProficiencyEnum < Types::BaseEnum
    value "NONE", value: "no_proficiency"
    value "ELEMENTARY", value: "elementary_proficiency"
    value "LIMITED", value: "limited_working_proficiency"
    value "WORKING", value: "professional_working_proficiency"
    value "PROFESSIONAL", value: "full_professional_proficiency"
    value "NATIVE", value: "native_proficiency"
  end
end
