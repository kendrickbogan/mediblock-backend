# frozen_string_literal: true

module Types
  class BoardCertificationQuestionnaireType < Types::BaseObject
    field :has_taken_certification_exam, Boolean, null: false
    field :has_taken_certification_exam_board_name, String, null: true

    field :taken_part_one_part_two_eligible, Boolean, null: false
    field :taken_part_one_part_two_eligible_board_name, String, null: true

    field :planning_to_take_exam, Boolean, null: false
    field :expected_exam_date, GraphQL::Types::ISO8601DateTime, null: true

    field :comments, String, null: true
  end
end
