class CreateDriversLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :drivers_licenses do |t|
      t.string :issuing_state, null: false
      t.timestamp :expiration_date, null: false
      t.references :person, index: true, foreign_key: true, null: false
      t.string :number, null: false

      t.timestamps
    end
  end
end
