class CreateMalpracticeClaims < ActiveRecord::Migration[6.1]
  def change
    create_table :malpractice_claims do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.timestamp :alleged_incident_date, null: false
      t.timestamp :claim_filed_at, null: false
      t.string :claim_status
      t.string :insurance_carrier_involved
      t.string :policy_number_covered_by
      t.money :settlement_amount
      t.money :amount_paid
      t.integer :method_of_resolution, default: 0, null: false
      t.string :resolution_comment
      t.string :description_of_allegations
      t.integer :defendant_type, default: 0, null: false
      t.integer :number_of_co_defendants, default: 0, null: false
      t.string :involvement_description
      t.string :description_of_alleged_injury
      t.boolean :included_in_npdb, default: false, null: false

      t.timestamps
    end
  end
end
