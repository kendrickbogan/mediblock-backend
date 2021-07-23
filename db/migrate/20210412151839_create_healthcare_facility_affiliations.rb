class CreateHealthcareFacilityAffiliations < ActiveRecord::Migration[6.1]
  def change
    create_table :healthcare_facility_affiliations do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :facility_name, null: false
      t.string :facility_type
      t.string :department_or_division_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code

      t.integer :membership_status, default: 0, null: false

      t.string :medical_staff_office_phone_number
      t.string :medical_staff_office_fax_number

      t.boolean :privilege_limitations, default: false, null: false

      t.string :comments

      t.timestamp :started_at, null: false
      t.timestamp :ended_at
      t.timestamps
    end
  end
end
