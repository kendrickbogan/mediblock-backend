# frozen_string_literal: true

class BoardCertificationQuestionnaire < ApplicationRecord
  belongs_to :board_certification

  validates :board_certification, presence: true

  validates :expected_exam_date,
            presence: true,
            if: -> { planning_to_take_exam }
end
