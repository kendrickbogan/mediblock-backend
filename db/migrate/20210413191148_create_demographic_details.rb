class CreateDemographicDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :demographic_details do |t|
      t.references :person, index: true, foreign_key: true, null: false

      t.string :race, null: false
      t.integer :ethnicity, default: 0, null: false

      t.timestamps
    end
  end
end
