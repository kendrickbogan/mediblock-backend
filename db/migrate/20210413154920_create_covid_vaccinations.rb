class CreateCOVIDVaccinations < ActiveRecord::Migration[6.1]
  def change
    create_table :covid_vaccinations do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.timestamp :vaccination_date_1, null: false
      t.timestamp :vaccination_date_2, null: false
      t.string :facility_name, null: false
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip
      t.timestamps
    end
  end
end
