class CreateInfluenzaVaccinations < ActiveRecord::Migration[6.1]
  def change
    create_table :influenza_vaccinations do |t|
      t.references :person, index: true, foreign_key: true, null: false
      t.boolean :has_been_vaccinated, null: false, default: false
      t.string :flu_season
      t.string :facility_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :no_vaccination_comment

      t.timestamp :vaccinated_at
      t.timestamps
    end
  end
end
