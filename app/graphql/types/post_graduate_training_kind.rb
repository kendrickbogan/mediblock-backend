# frozen_string_literal: true

module Types
  class PostGraduateTrainingKind < Types::BaseEnum
    value "INTERNSHIP", value: "internship"
    value "FELLOWSHIP", value: "fellowship"
    value "RESIDENCY", value: "residency"
  end
end
