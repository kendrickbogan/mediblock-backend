class CreateHospitalAffiliations < ActiveRecord::Migration[6.1]
  def change
    create_table :hospital_affiliations do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :hospital_name
      t.string :department_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code

      t.integer :membership_status, default: 0, null: false

      t.string :staff_office_phone_number
      t.string :staff_office_fax_number

      t.boolean :privilege_limitations, default: false, null: false

      t.string :comments

      t.timestamp :started_at
      t.timestamp :ended_at
      t.timestamps
    end
  end
end
