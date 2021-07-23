# frozen_string_literal: true

class ProfessionalLiabilityJudgmentsQuestionnaire < ApplicationRecord
  belongs_to :person

  validates :person, presence: true

  validates :judgments_entered,
            :liability_claim_settlements_paid,
            :pending_liability_actions,
            :any_legal_action_due_to_clinical_actions,
            inclusion: [true, false]
end
