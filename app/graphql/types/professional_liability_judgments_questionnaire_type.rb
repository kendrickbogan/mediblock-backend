# frozen_string_literal: true

module Types
  class ProfessionalLiabilityJudgmentsQuestionnaireType < Types::BaseObject
    field :person, Types::PersonType, null: false
    field :judgments_entered, Boolean, null: false
    field :liability_claim_settlements_paid, Boolean, null: false
    field :pending_liability_actions, Boolean, null: false
    field :any_legal_action_due_to_clinical_actions, Boolean, null: false
  end
end
