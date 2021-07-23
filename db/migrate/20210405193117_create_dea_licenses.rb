class CreateDEALicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :dea_licenses do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.string :registration_number, null: false
      t.timestamp :expiration_date, null: false
      t.string :status, null: false
      t.boolean :unrestricted, default: false, null: false

      t.timestamps
    end
  end
end
