# frozen_string_literal: true

module Types
  class SpokenLanguageInput < Types::BaseInputObject
    description "Input to create or edit spoken_languages"
    argument :language, String, required: true
    argument :reading_proficiency, Types::LanguageProficiencyEnum, required: true
    argument :speaking_proficiency, Types::LanguageProficiencyEnum, required: true
    argument :writing_proficiency, Types::LanguageProficiencyEnum, required: true
  end
end
