class RefactorStateMedicalLicenses < ActiveRecord::Migration[6.1]
  def change
    rename_table :state_medical_licenses, :professional_licenses
    add_column :professional_licenses, :kind, :integer, default: 0, null: false
    add_column :professional_licenses, :non_medical_license_kind, :string
  end
end
