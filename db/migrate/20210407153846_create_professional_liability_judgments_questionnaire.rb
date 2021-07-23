class CreateProfessionalLiabilityJudgmentsQuestionnaire < ActiveRecord::Migration[6.1]
  def change
    create_table :professional_liability_judgments_questionnaires do |t|
      t.references :person,
                   index: { name: "index_liability_questionnaire_on_person_id" },
                   foreign_key: true,
                   null: false

      t.boolean :judgments_entered, default: false, null: false
      t.boolean :liability_claim_settlements_paid, default: false, null: false
      t.boolean :pending_liability_actions, default: false, null: false
      t.boolean :any_legal_action_due_to_clinical_actions, default: false, null: false

      t.timestamps
    end
  end
end
