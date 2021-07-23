class AddUrlToProfessionalLicenses < ActiveRecord::Migration[6.1]
  def change
    change_table :professional_licenses do |t|
      t.string :license_verification_url
    end
  end
end
