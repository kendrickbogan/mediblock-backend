class AddLegalBusinessName < ActiveRecord::Migration[6.1]
  def change
    change_table :healthcare_facility_affiliations do |t|
      t.string :facility_legal_business_name
    end
    change_table :medical_group_employers do |t|
      t.string :legal_business_name
    end
    change_table :hospital_affiliations do |t|
      t.string :hospital_legal_business_name
    end
  end
end
