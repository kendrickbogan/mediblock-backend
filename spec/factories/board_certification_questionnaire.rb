# frozen_string_literal: true

FactoryBot.define do
  factory :board_certification_questionnaire do
    board_certification

    has_taken_certification_exam { true }
    has_taken_certification_exam_board_name { "Board name" }

    taken_part_one_part_two_eligible { true }
    taken_part_one_part_two_eligible_board_name { "Board name" }

    planning_to_take_exam { true }
    expected_exam_date { 1.month.from_now }
  end
end
