# frozen_string_literal: true

class ProfessionalLicense < ApplicationRecord
  include ExpirableItem

  belongs_to :person

  expirable_category CATEGORIES[:PROFESSIONAL_LICENSE]

  enum kind: { medical: 0, xray_fluoroscopy: 1, other: 2 }

  validates :person, :date_of_issue, presence: true

  validates :issuing_state,
            inclusion: CS.states(:US).values,
            if: -> { issuing_state.present? }

  def profile_section
    case kind
    when "medical"
      PROFILE_SECTIONS[:STATE_MEDICAL_LICENSES]
    when "xray_fluoroscopy"
      PROFILE_SECTIONS[:STATE_XRAY_FLUOROSCOPY_LICENSE]
    when "other"
      PROFILE_SECTIONS[:OTHER_STATE_PROFESSIONAL_LICENSES]
    end
  end
end
