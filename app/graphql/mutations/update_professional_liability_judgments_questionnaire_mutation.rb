# frozen_string_literaL: true

module Mutations
  class UpdateProfessionalLiabilityJudgmentsQuestionnaireMutation < Mutations::BaseMutation
    null true

    argument :judgments_entered, Boolean, required: true
    argument :liability_claim_settlements_paid, Boolean, required: true
    argument :pending_liability_actions, Boolean, required: true
    argument :any_legal_action_due_to_clinical_actions, Boolean, required: true

    field :professional_liability_judgments_questionnaire,
          Types::ProfessionalLiabilityJudgmentsQuestionnaireType,
          null: true

    def resolve(args)
      if person.present?
        questionnaire = find_or_init_questionnaire
        questionnaire.update(args)

        if questionnaire.valid?
          { professional_liability_judgments_questionnaire: questionnaire }
        else
          { professional_liability_judgments_questionnaire: nil }
        end
      else
        raise_unauthenticated_error
      end
    end

    def find_or_init_questionnaire
      person.professional_liability_judgments_questionnaire ||
        ProfessionalLiabilityJudgmentsQuestionnaire.new(person: person)
    end
  end
end
