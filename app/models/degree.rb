# frozen_string_literal: true

class Degree < ApplicationRecord
  include StartAndEndValidations

  belongs_to :person

  enum kind: { undergraduate: 0, other: 1 }

  validates :person,
            :kind,
            :date_of_graduation,
            :started_at,
            :ended_at,
            presence: true

  validates :major,
            presence: true,
            if: -> { undergraduate? }

  validates :institution_address_country,
            inclusion: CS.countries.values,
            if: -> { institution_address_country.present? }

  validates :institution_address_state,
            inclusion: CS.states(:US).values,
            if: -> { institution_address_state.present? }

  def institution_address
    [
      institution_address_line_1,
      institution_address_line_2,
      institution_address_line_3,
      institution_address_city,
      institution_address_state,
      institution_address_zip,
      institution_address_country
    ].reject(&:blank?).join(", ")
  end
end
