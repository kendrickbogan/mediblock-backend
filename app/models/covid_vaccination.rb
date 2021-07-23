# frozen_string_literal: true

class COVIDVaccination < ApplicationRecord
  belongs_to :person

  validates :person,
            :vaccination_date_1,
            :vaccination_date_2,
            presence: true

  validates :state, inclusion: CS.states(:US).values, if: -> { state.present? }

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
