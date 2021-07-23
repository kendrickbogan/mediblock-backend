# frozen_string_literal: true

class InfluenzaVaccination < ApplicationRecord
  belongs_to :person

  validates :has_been_vaccinated, inclusion: [true, false]
  validates :vaccinated_at, presence: true, if: :has_been_vaccinated?

  def facility_address
    [
      address_line_1,
      address_line_2,
      city,
      state,
      zip
    ].reject(&:blank?).join(", ")
  end
end
