# frozen_string_literal: true

module Types
  class CertificationQuestionnaireInput < Types::BaseInputObject
    description "Input for creating or editing a board certification questionnaire"
    argument :has_taken_certification_exam, Boolean, required: false
    argument :has_taken_certification_exam_board_name, String, required: false

    argument :taken_part_one_part_two_eligible, Boolean, required: false
    argument :taken_part_one_part_two_eligible_board_name, String, required: false

    argument :planning_to_take_exam, Boolean, required: false
    argument :expected_exam_date, GraphQL::Types::ISO8601DateTime, required: false

    argument :comments, String, required: false

    def with_indifferent_access
      to_h
    end
  end
end
