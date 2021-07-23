# frozen_string_literal: true

class InsurancePolicy < ApplicationRecord
  belongs_to :person

  enum claims_coverage_type: { unknown: 0, claims_made: 1, occurrence: 2 }, _prefix: true
  enum coverage_type: { unknown: 0, individual: 1, shared: 2 }, _prefix: true

  validates :person, presence: true
  validates :covered_by_ftca, :tail_coverage, inclusion: [true, false]
  validates :per_claim_amount, :aggregate_amount, numericality: true

  validates :state, inclusion: CS.states(:US).values, if: -> { state.present? }

  def address
    [
      street_address,
      city,
      state,
      zip_code
    ].reject(&:blank?).join(", ")
  end
end
