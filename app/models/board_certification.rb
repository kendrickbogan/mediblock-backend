# frozen_string_literal: true

class BoardCertification < ApplicationRecord
  include ExpirableItem

  expirable_category CATEGORIES[:BOARD_CERTIFICATION]

  belongs_to :person
  has_one :board_certification_questionnaire, dependent: :destroy

  accepts_nested_attributes_for :board_certification_questionnaire

  enum specialty_rank: { primary: 0, secondary: 1 }

  validates :person, :specialty_rank, presence: true

  validates :board_certified, inclusion: [true, false]

  validates :initial_certification_date,
            presence: true,
            if: -> { board_certified }

  def profile_section
    PROFILE_SECTIONS[:"#{specialty_rank}_SPECIALTY".upcase]
  end
end
