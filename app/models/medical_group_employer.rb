# frozen_string_literal: true

class MedicalGroupEmployer < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  validates :person, :started_at, presence: true

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
      zip,
      country
    ].reject(&:blank?).join(", ")
  end
end
