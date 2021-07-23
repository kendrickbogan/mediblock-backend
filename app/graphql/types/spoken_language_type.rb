# frozen_string_literal: true

module Types
  class SpokenLanguageType < Types::BaseObject
    field :id, ID, null: false
    field :language, String, null: false
    field :reading_proficiency, Types::LanguageProficiencyEnum, null: false
    field :speaking_proficiency, Types::LanguageProficiencyEnum, null: false
    field :writing_proficiency, Types::LanguageProficiencyEnum, null: false
  end
end
