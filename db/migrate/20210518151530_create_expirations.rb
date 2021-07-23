class CreateExpirations < ActiveRecord::Migration[6.1]
  def change
    create_table :expirations do |t|
      t.references :expirable, polymorphic: true, index: true, null: false
      t.references :person, index: true, foreign_key: true, null: false
      t.integer :category, default: 0, null: false
      t.integer :profile_section, default: 0, null: true
      t.timestamp :expires_at, null: false

      t.timestamps
    end

    remove_column :board_certifications, :expiration_date, :timestamp, null: false, default: 1.year.from_now
    remove_column :certifications, :renewal_recommended_at, :timestamp, null: false, default: 1.year.from_now
    remove_column :dea_licenses, :expiration_date, :timestamp, null: false, default: 1.year.from_now
    remove_column :documents, :expires_at, :timestamp, null: false, default: 1.year.from_now
    remove_column :drivers_licenses, :expiration_date, :timestamp, null: false, default: 3.years.from_now
    remove_column :passports, :expiration_date, :timestamp, null: false, default: 1.year.from_now
    remove_column :professional_licenses, :expiration_date, :timestamp, null: false, default: 1.year.from_now
  end
end
