# frozen_string_literal: true

class MalpracticeClaim < ApplicationRecord
  belongs_to :person

  enum method_of_resolution: {
    dismissed: 0,
    settled_with_prejudice: 1,
    settled_without_prejudice: 2,
    judgement_for_plantiff: 3,
    judgement_for_defendant: 4,
    mediation_or_arbitration: 5,
    other: 6
  }

  enum defendant_type: { primary: 0, co: 1 }, _suffix: true

  validates :person, :alleged_incident_date, presence: true
  validates :included_in_npdb, inclusion: [true, false]
end
