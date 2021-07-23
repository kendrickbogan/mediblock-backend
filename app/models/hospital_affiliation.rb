# frozen_string_literal: true

class HospitalAffiliation < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  enum membership_status: {
    inactive: 0,
    active: 1,
    provisional: 2,
    courtesy: 3,
    temporary: 4
  }

  validates :state, inclusion: CS.states(:US).values, if: -> { state.present? }
  validates :country, inclusion: CS.countries.values, if: -> { country.present? }

  def current?
    ended_at.nil? || Time.current < ended_at
  end

  def full_address
    [
      address_line_1,
      address_line_2,
      city,
      state,
      zip_code,
      country
    ].reject(&:blank?).join(", ")
  end
end
