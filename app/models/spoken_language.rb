# frozen_string_literal: true

class SpokenLanguage < ApplicationRecord
  belongs_to :person

  PROFICIENCY_LEVELS = {
    no_proficiency: 0,
    elementary_proficiency: 1,
    limited_working_proficiency: 2,
    professional_working_proficiency: 3,
    full_professional_proficiency: 4,
    native_proficiency: 5
  }.freeze

  enum reading_proficiency: PROFICIENCY_LEVELS, _suffix: :in_reading
  enum speaking_proficiency: PROFICIENCY_LEVELS, _suffix: :in_speaking
  enum writing_proficiency: PROFICIENCY_LEVELS, _suffix: :in_writing

  validates :language,
            :speaking_proficiency,
            :writing_proficiency,
            :reading_proficiency,
            presence: true
end
