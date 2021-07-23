class CreateProfessionalLiabilityInsuranceCarriers < ActiveRecord::Migration[6.1]
  def change
    create_table :professional_liability_insurance_carriers do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :malpractice_type

      t.string :organization_name, null: false
      t.string :organization_address_line_1
      t.string :organization_address_line_2
      t.string :organization_city
      t.string :organization_state
      t.string :organization_zip
      t.string :organization_phone_number
      t.string :organization_email_address
      t.string :organization_fax_number

      t.string :contact_person_first_name
      t.string :contact_person_last_name
      t.string :contact_person_role
      t.string :contact_person_phone_number
      t.string :contact_person_email_address
      t.string :contact_person_fax_number

      t.timestamps
    end
  end
end
