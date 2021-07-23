class CreateInsurancePolicies < ActiveRecord::Migration[6.1]
  def change
    create_table :insurance_policies do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :entity_name
      t.boolean :self_insured, null: false, default: false
      t.boolean :covered_by_ftca, null: false, default: false
      t.boolean :tail_coverage, null: false, default: false
      t.string :policy_number, null: false, default: false
      t.money :per_claim_amount, null: false, default: 0
      t.money :aggregate_amount, null: false, default: 0
      t.timestamp :started_at
      t.timestamp :ended_at

      t.integer :claims_coverage_type, default: 0, null: false
      t.integer :coverage_type, default: 0, null: false

      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :email
      t.string :phone_number
      t.string :fax_number
      t.string :url

      t.timestamps
    end
  end
end
