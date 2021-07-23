class CreateStateMedicalLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :state_medical_licenses do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :issuing_state, null: false
      t.string :issuing_authority, null: false
      t.string :number, null: false
      t.string :date_of_issue, null: false
      t.timestamp :expiration_date, null: false
      t.string :status, null: false
      t.boolean :unrestricted_license, null: false

      t.timestamps
    end
  end
end
