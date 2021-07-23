# frozen_string_literal: true

class ProfessionalLiabilityInsuranceCarrier < ApplicationRecord
  belongs_to :person

  validates :person, presence: true

  def organization_address
    [
      organization_address_line_1,
      organization_address_line_2,
      organization_city,
      organization_state,
      organization_zip
    ].reject(&:blank?).join(", ")
  end
end
