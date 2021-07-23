class CreateNationalHealthServiceCorpsScholarships < ActiveRecord::Migration[6.1]
  def change
    create_table :national_health_service_corps_scholarships do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.timestamp :started_at, null: false
      t.timestamp :ended_at, null: false

      t.timestamps
    end
  end
end
